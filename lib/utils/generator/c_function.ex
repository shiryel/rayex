defmodule Utils.Generator.CFunction do
  @moduledoc false

  @doc """
    Rules:
    * All functions will be lower_cased
    * Functions that can't be parsed will be comment with a `TODO:`
  """
  def parser(line) do
    # reverse pointer symbols, so we can work with them more easily
    line_ =
      String.replace(line, " **", "** ")
      |> String.replace(" *", "* ")

    regex = ~r/(?<return>.*) (?<function>[[:alnum:]]+)\((?<params>.*)\).*\/\/ ?(?<doc>.*)/

    case Regex.named_captures(regex, line_) do
      %{
        "function" => function,
        "params" => params,
        "return" => return
      } ->
        """
        static ERL_NIF_TERM #{Macro.underscore(function)}(ErlNifEnv *env, int argc,
                                        const ERL_NIF_TERM argv[]) {
        #{body(function, params, return)}}
        """

      nil ->
        """
          // TODO: not implemented
          // #{line}
        """
    end
  end

  # Example:
  # "function" => "InitWindow",
  # "params" => "int width, int height, const char *title",
  # "return_type" => "void"
  def body(function, params, return_type) do
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
        // binding
        #{bind}

        // free memory
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
    ~S|return enif_make_atom(env, "ok");|
  end
end
