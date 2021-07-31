defmodule Utils.Generator.ElixirFunction do
  @moduledoc false
  require Logger

  @doc """
    Rules:
    * All functions will be lower_cased
    * If functions returns bool and starts with Is or ends with Exists will be put a ? on the end (TODO)
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
        "doc" => doc,
        "return" => return
      } ->
        function_snaked = Macro.underscore(function)

        """
          @doc "#{doc}"
          @type #{function_snaked}#{parse_type(params, return)}
          def #{function_snaked}#{elixir_params(params)},
            do: raise("NIF #{function_snaked} not implemented")
        """

      nil ->
        """
          # TODO: not implemented
          # #{line}
        """
    end
  end

  #########
  # @type #
  #########

  # Example:
  # "params" => "int width, int height, const char *title",
  # "return_type" => "void"
  defp parse_type(params, return) do
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

    # remove () on @type if not needed
    if new_params == "" do
      " :: #{new_return}"
    else
      "(#{new_params}) :: #{new_return}"
    end
  end

  @c_types %{
    "bool" => "boolean()",
    "int" => "integer()",
    "int*" => "integer()",
    "unsigned int" => "pos_integer()",
    "unsigned int*" => "pos_integer()",
    "short*" => "integer()",
    "unsigned short" => "pos_integer()",
    "char*" => "String.t()",
    "char**" => "String.t()",
    "unsigned char*" => "String.t()",
    "unsigned char**" => "String.t()",
    "void" => ":ok"
  }

  defp parse_c_type(c_type) do
    # NOTE:
    # - the string can start with a space
    # - its not expecting modifiers like const and static
    # - voids are converted to :ok
    regex = ~r/ ?(?<type>([[:alnum:]]|\ )+\*?\*?) /

    case Regex.named_captures(regex, c_type) do
      %{"type" => type} ->
        result = Map.get(@c_types, type)

        result ||
          (
            # don't find any, so... custom result
            Logger.debug("Parsing custom: #{inspect(c_type)}")
            "#{Macro.underscore(type)}()"
          )

      nil ->
        Logger.error("Could not paser: #{inspect(c_type)}")
        c_type
    end
  end

  #######
  # def #
  #######

  # Example:
  # "params" => "int width, int height, const char *title",
  defp elixir_params(params) do
    result =
      params
      |> String.split(",")
      |> Enum.map(&parse_c_param/1)
      |> Enum.reject(fn x -> x == "void" end)
      |> Enum.join(", ")

    # remove () on def if not needed
    if result == "" do
      ""
    else
      "(#{result})"
    end
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
end
