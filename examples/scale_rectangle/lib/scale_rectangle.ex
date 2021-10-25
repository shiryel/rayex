defmodule ScaleRectangle do
  @moduledoc """
  Documentation for `ScaleRectangle`.
  """

  import Rayex

  def run do
    init_window(700, 700, "scale rectangle example")
    set_target_fps(60)

    state = update_state(%{})
    game_loop(state)
  end

  @mouse_mark_size 12
  @mouse_left 0
  @color_white %{r: 245, g: 245, b: 245, a: 255}
  @color_gray %{r: 130, g: 130, b: 130, a: 255}
  @color_red %{r: 230, g: 41, b: 55, a: 255}
  @color_green_a %{r: 0, g: 228, b: 48, a: 126}

  def game_loop(%{rec: rec} = state) do
    state = update_state(state)
    mouse = get_mouse_position()

    IO.inspect(state)

    # update rec
    rec =
      if mouse_scale_ready?(mouse, rec) and state.mouse == :pressed do
        rec = %{rec | width: mouse.x - rec.x, height: mouse.y - rec.y}
        rec = (rec.width < @mouse_mark_size && %{rec | width: @mouse_left}) || rec
        (rec.height < @mouse_mark_size && %{rec | width: @mouse_left}) || rec
      end

    state = %{state | rec: rec}

    #
    # draw
    #
    begin_drawing()

    clear_background(@color_white)
    draw_text("Scale rectangle dragging from bottom-right corner!", 10, 10, 20, @color_gray)
    draw_rectangle_rec(rec, @color_green_a)

    if mouse_scale_ready?(mouse, rec) do
      draw_rectangle_lines_ex(rec, 1, @color_red)

      draw_triangle(
        %{x: rec.x + rec.width - @mouse_mark_size, y: rec.y + rec.height},
        %{x: rec.x + rec.width, y: rec.y + rec.height},
        %{x: rec.x + rec.width, y: rec.y + rec.height - @mouse_mark_size},
        @color_red
      )
    end

    end_drawing()

    game_loop(state)
  end

  defp mouse_scale_ready?(mouse, rec) do
    border_rec = %{
      x: rec.x + rec.width - @mouse_mark_size,
      y: rec.height - @mouse_mark_size,
      width: @mouse_mark_size,
      height: @mouse_mark_size
    }

    check_collision_point_rec(mouse, rec) and check_collision_point_rec(mouse, border_rec)
  end

  defp update_state(state) do
    # mouse
    mouse =
      (is_mouse_button_pressed(@mouse_left) && :pressed) || Map.get(state, :mouse, :released)

    state = Map.put(state, :mouse, mouse)

    mouse =
      (is_mouse_button_released(@mouse_left) && :released) || Map.get(state, :mouse, :released)

    state = Map.put(state, :mouse, mouse)
    # rec
    rec = Map.get(state, :rec, %{x: 100, y: 100, width: 200, height: 80})
    Map.put(state, :rec, rec)
  end
end
