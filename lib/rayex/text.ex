defmodule Rayex.Text do
  @moduledoc """
    Text related functions
  """

  alias Rayex.Structs, as: S
  alias Rayex.Unifex.Raylib
  # Font loading/unloading functions

  # Text drawing functions

  @doc "Draw current FPS"
  @spec draw_fps(integer(), integer()) :: :ok
  defdelegate draw_fps(pos_x, pos_y), to: Raylib

  @doc "Draw text (using default font)"
  @spec draw_text(String.t(), integer(), integer(), integer(), S.Color.t()) :: :ok
  defdelegate draw_text(text, pos_x, pos_y, font_size, color), to: Raylib

  # Text misc. functions

  # Text codepoints management functions (unicode characters)

  # Text strings management functions (no utf8 strings, only byte chars)
  # NOTE: Some strings allocate memory internally for returned strings, just be careful!
end
