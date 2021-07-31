defmodule Mix.Tasks.Compile.Raylib do
  @moduledoc """
    Compiles the raylib C nif code using Makefile
  """
  @shortdoc "Compiles raylib C nif"

  use Mix.Task

  @impl true
  def run(_args) do
    {result, _errcode} = System.cmd("make", [], stderr_to_stdout: true)
    IO.puts(result)
  end
end
