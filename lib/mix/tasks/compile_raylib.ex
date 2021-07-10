defmodule Mix.Tasks.Compile.Raylib do
  use Mix.Task

  def run(_args) do
    {result, _errcode} = System.cmd("make", [], stderr_to_stdout: true)
    IO.puts(result)
  end
end
