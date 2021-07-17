defmodule Utils.Generator do
  @moduledoc """
    This module is for internal use!

    It is used to generate all the raylib functions both on elixir and in C code from the raylib cheatsheet
  """

  require Logger
  alias __MODULE__.{CBoilerplate, CFunction, ElixirBoilerplate, ElixirFunction}

  @doc """
    Generate the files from a list of C function descriptions
  """
  @spec create_files([String.t()], String.t(), String.t()) :: :ok
  def create_files(lines, elixir_name, c_name) do
    module = Macro.camelize(elixir_name)

    functions = Enum.map(lines, &__MODULE__.CBoilerplate.get_function/1)

    elixir_result =
      [
        ElixirBoilerplate.include(module, "priv/#{c_name}"),
        Stream.map(lines, &ElixirFunction.parser/1)
        |> Enum.join("\n"),
        "end"
      ]
      |> Enum.join("\n")

    c_result =
      [
        CBoilerplate.include(),
        Stream.map(lines, &CFunction.parser/1)
        |> Enum.join("\n"),
        CBoilerplate.nif_stuff(functions, "Elixir.Rayex.#{module}")
      ]
      |> Enum.join("\n")

    File.write!(Path.expand(elixir_name <> ".ex"), elixir_result)
    File.write!(Path.expand(c_name <> ".c"), c_result)
  end
end
