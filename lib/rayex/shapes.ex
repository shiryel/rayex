defmodule Rayex.Shapes do
  @moduledoc """
    Shapes related functions
  """

  alias Rayex.Structs, as: S
  alias Rayex.Unifex.Raylib

  # Set texture and rectangle to be used on shapes drawing
  # NOTE: It can be useful when using basic shapes and one single font,
  # defining a font char white rectangle would allow drawing everything in a single draw call

  @doc "Set texture and rectangle to be used on shapes drawing"
  @spec set_shapes_texture(S.Texture2D.t(), S.Rectangle.t()) :: :ok
  defdelegate set_shapes_texture(texture, source), to: Raylib

  # Basic shapes drawing functions

  @doc "Draw a pixel"
  @spec draw_pixel(integer(), integer(), S.Color.t()) :: :ok
  defdelegate draw_pixel(x, y, color), to: Raylib

  @doc "Draw a line"
  @spec draw_line(integer(), integer(), integer(), integer(), S.Color.t()) :: :ok
  defdelegate draw_line(start_x, start_y, end_x, end_y, color), to: Raylib

  @doc "Draw a color-filled circle"
  @spec draw_circle(integer(), integer(), float(), S.Color.t()) :: :ok
  defdelegate draw_circle(center_x, center_y, radius, color), to: Raylib

  @doc "Draw a color-filled circle (Vector version)"
  @spec draw_circle_v(S.Vector2.t(), float(), S.Color.t()) :: :ok
  defdelegate draw_circle_v(center, radius, color), to: Raylib

  @doc "Draw a color-filled rectangle"
  @spec draw_rectangle_rec(S.Rectangle.t(), S.Color.t()) :: :ok
  defdelegate draw_rectangle_rec(rectangle, color), to: Raylib

  @doc "Draw a color-filled rectangle with pro parameters"
  @spec draw_rectangle_pro(S.Rectangle.t(), S.Vector2.t(), float(), S.Color.t()) :: :ok
  defdelegate draw_rectangle_pro(rectangle, origin, rotation, color), to: Raylib

  @doc "Draw rectangle outline with extended parameters"
  @spec draw_rectangle_lines_ex(S.Rectangle.t(), integer(), S.Color.t()) :: :ok
  defdelegate draw_rectangle_lines_ex(rectangle, line_thick, color), to: Raylib

  @doc "Draw a color-filled triangle (vertex in counter-clockwise order!)"
  @spec draw_triangle(S.Vector2.t(), S.Vector2.t(), S.Vector2.t(), S.Color.t()) :: :ok
  defdelegate draw_triangle(vertice1, vertice2, vertice3, color), to: Raylib

  @doc "Draw a regular polygon (Vector version)"
  @spec draw_poly(S.Vector2.t(), integer(), float(), float(), S.Color.t()) :: :ok
  defdelegate draw_poly(center, sides, radius, rotation, color), to: Raylib

  # Basic shapes collision detection functions

  @doc "Check collision between two circles"
  @spec check_collision_circles(S.Vector2.t(), float(), S.Vector2.t(), float()) :: boolean()
  defdelegate check_collision_circles(center1, radius1, center2, radius2), to: Raylib

  @doc "Check if point is inside rectangle"
  @spec check_collision_point_rec(S.Vector2.t(), S.Rectangle.t()) :: boolean()
  defdelegate check_collision_point_rec(point, rectangle), to: Raylib

  @doc "Get collision info between ray and box"
  @spec get_ray_collision_box(S.Ray.t(), S.BoundingBox.t()) :: S.RayCollision.t()
  defdelegate get_ray_collision_box(ray, bounding_box), to: Raylib
end
