defmodule Utils.Generator do
  @moduledoc """
    This module is for internal use!

    It is used to generate all the raylib functions both on elixir and in C code from the raylib cheatsheet
  """

  require Logger

  def create_files(parser_result, elixir_name, c_name) do
    {elixir_result, c_result} = parser_result

    elixir_result =
      """
      defmodule Rayex.#{Macro.camelize(elixir_name)} do
        @on_load :load_nifs

        def load_nifs do
          :erlang.load_nif('priv/#{c_name}', 0)
        end
      """ <> elixir_result <> "end"

    c_result =
      """
      #include "erl_nif.h"
      #include "raylib.h"
      """ <>
        c_result <>
        """
        /************
        * NIF INIT *
        ************/

        static ErlNifFunc nif_funcs[] = {
        // {erl_function_name, erl_function_arity, c_function}
        {"init_window", 3, init_window}};

        static int load(ErlNifEnv *env, void **priv_data, ERL_NIF_TERM load_info) {
        return 0;
        }

        static int upgrade(ErlNifEnv *env, void **priv_data, void **old_priv_data,
                 ERL_NIF_TERM load_info) {
        return 0;
        }

        static int reload(ErlNifEnv *env, void **priv_data, ERL_NIF_TERM load_info) {
        return 0;
        }

        static void unload(ErlNifEnv *env, void *priv_data) {}

        // needs to be the same module on elixir
        ERL_NIF_INIT(Elixir.Rayex.Core, nif_funcs, load, reload, upgrade, unload)
        """

    File.write!(Path.expand(elixir_name <> ".ex"), elixir_result)
    File.write!(Path.expand(c_name <> ".c"), c_result)
  end

  @doc """
    Rules:
    * All functions will be lower_cased
    * If functions returns bool and starts with Is or ends with Exists will be put a ? on the end
    * Functions that can't be parsed will be comment with a `TODO:`
  """
  def parser(line) do
    regex = ~r/(?<return>.*) (?<function>[[:alnum:]]+)\((?<params>.*)\).*\/\/ ?(?<doc>.*)/

    case Regex.named_captures(regex, line) do
      %{
        "function" => function,
        "params" => params,
        "doc" => doc,
        "return" => return
      } ->
        function_snaked = Macro.underscore(function)

        {
          """
            @doc "#{doc}"
            @type #{function_snaked}#{elixir_type(params, return)}
            def #{function_snaked}#{elixir_params(params)},
              do: raise("NIF #{function_snaked} not implemented")
          """,
          """
            static ERL_NIF_TERM #{Macro.underscore(function)}(ErlNifEnv *env, int argc,
                                                             const ERL_NIF_TERM argv[]) {
              #{c_body(function, params, return)}
            }
          """
        }

      nil ->
        {"""
           # TODO: not implemented
           # #{line}
         """,
         """
           // TODO: not implemented
           // #{line}
         """}
    end
  end

  #################
  # ELIXIR PARSER #
  #################

  # Example:
  # "params" => "int width, int height, const char *title",
  # "return_type" => "void"
  defp elixir_type(params, return) do
    # we don't need to worry about modifiers
    modifiers = ~r/(static|const)+\ /

    new_params =
      params
      # "int width, int height, const char *title"
      |> String.replace(modifiers, "")
      # "int width, int height, char *title"
      |> String.split(",")
      # ["int width", " int height", " char *title"]
      |> Enum.reject(fn x -> x == "void" end)
      |> Enum.map(&parse_c_type/1)
      |> Enum.join(", ")

    new_return =
      (String.replace(return, modifiers, "") <> " ")
      |> parse_c_type()

    "(#{new_params}) :: #{new_return}"
  end

  defp parse_c_type(c_type) do
    # NOTE: 
    # - the string can start with a space
    # - its not expecting modifiers like const and static
    # - voids are converted to :ok
    regex = ~r/ ?(?<type>([[:alnum:]]|\ )+) (?<modifier>\*?)/

    case Regex.named_captures(regex, c_type) do
      # int
      %{"type" => "int"} ->
        "integer()"

      %{"type" => "unsigned int"} ->
        "pos_integer()"

      # short
      %{"type" => "short"} ->
        "integer()"

      %{"type" => "unsigned short"} ->
        "post_integer()"

      # long
      %{"type" => "long"} ->
        "integer()"

      %{"type" => "unsigned long"} ->
        "post_integer()"

      # string
      %{"type" => "char", "modifier" => "*"} ->
        "String.t()"

      # void
      %{"type" => "void"} ->
        ":ok"

      # custom
      %{"type" => type} ->
        Logger.debug("Parsing custom: #{inspect(c_type)}")
        type

      nil ->
        Logger.error("Could not paser: #{inspect(c_type)}")
        c_type
    end
  end

  # Example:
  # "params" => "int width, int height, const char *title",
  defp elixir_params(params) do
    params
    |> String.split(",")
    |> Enum.map(&parse_c_param/1)
    |> Enum.join(", ")
    |> then(&"(#{&1})")
  end

  defp parse_c_param(c_type) do
    # NOTE:
    # because we only need the name we can get it from the end
    regex = ~r/(?<modifier>\*?) ?(?<name>[[:alnum:]]+)$/

    case Regex.named_captures(regex, c_type) do
      %{"name" => name} ->
        Macro.underscore(name)
    end
  end

  ############
  # C PARSER #
  ############

  # Example:
  # "function" => "InitWindow",
  # "params" => "int width, int height, const char *title",
  # "return_type" => "void"
  defp c_body(function, params, return_type) do
    # Build all the var parsers
    # (needs to join result)
    {result, to_free} =
      params
      |> format_params()
      |> Enum.with_index()
      |> Enum.map_reduce([], fn {x, index}, to_free ->
        [type, name] = String.split(x, " ")

        case type do
          "int" ->
            {c_int(name, index), to_free}

          "char*" ->
            {c_string(name, index), [name | to_free]}
        end
      end)

    # Build the binding function
    # (already ready)
    bind =
      params
      |> format_params()
      |> Enum.reduce([], fn x, acc ->
        [_type, name] = String.split(x, " ")
        [name | acc]
      end)
      |> Enum.reverse()
      |> Enum.join(", ")
      |> c_bind(function, return_type)

    # Build all the memomy free
    # (already ready)
    free =
      to_free
      |> Enum.map(&c_free/1)
      |> Enum.join("\n")

    # Glues everything together
    result
    |> Enum.join("\n")
    |> then(
      &"""
        #{&1}
        #{bind}
        #{free}
        #{c_return(return_type)}
      """
    )
  end

  # Format the params to follow this rules:
  # - The last word is always the name separated by a space
  # - The first words are the types
  # - Returned on a list
  # - Will not include void
  defp format_params(params) do
    # we don't need to worry about modifiers
    modifiers = ~r/(static|const)+\ /

    params
    # "int width, int height, const char *title"
    |> String.replace(modifiers, "")
    # "int width, int height, char *title"
    |> String.replace(" *", "* ")
    # "int width, int height, char* title"
    |> String.split(", ")
    # ["int width", "int height", "char* title"]
    |> Enum.reject(fn x -> x == "void" end)
  end

  #
  # Get Types
  #

  defp c_int(var_name, var_number) do
    """
      // var: #{var_name}
      int #{var_name};
      if (enif_get_int(env, argv[#{var_number}], &#{var_name}) < 1)
        return enif_make_badarg(env);
    """
  end

  # NOTE: after the use, needs to call c_free/1
  defp c_string(var_name, var_number) do
    """
      // var: #{var_name}
      unsigned int #{var_name}_len;
      enif_get_list_length(env, argv[#{var_number}], &#{var_name}_len);

      char *#{var_name} = enif_alloc(sizeof(char *) * (#{var_name}_len + 1));
      if (enif_get_string(env, argv[#{var_number}], #{var_name}, sizeof(#{var_name}), ERL_NIF_LATIN1) < 1)
        return enif_make_badarg(env);
    """
  end

  #
  # Binding
  #

  defp c_bind(var_list, function, "void") do
    "#{function}(#{var_list});"
  end

  defp c_bind(var_list, function, return_type) do
    "#{return_type} _result_ = #{function}(#{var_list});"
  end

  #
  # Memory
  #

  defp c_free(var_name) do
    "enif_free(#{var_name});"
  end

  #
  # Return
  #

  defp c_return(_) do
    """
      return enif_make_atom(env, "ok");
    """
  end
end
