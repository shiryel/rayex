defmodule Rayex do
  @moduledoc """
    Rayex is an almost 1 to 1 binding with raylib (with adapted names that fit the "elixir way")

    Raylib cheatsheet: https://www.raylib.com/cheatsheet/cheatsheet.html

    You can use `use Rayex` to import all modules functions or use each module direct under `Rayex`, like `Rayex.Core`
  """

  defmacro __using__(_opts) do
    quote do
      import Rayex.Audio
      import Rayex.Core
      import Rayex.Models
      import Rayex.Shapes
      import Rayex.Text
      import Rayex.Textures
    end
  end
end
