defmodule ScaleRectangle do
  @moduledoc """
  Documentation for `ScaleRectangle`.
  """

  require Logger
  use Rayex

  @mouse_mark_size 12.0
  @mouse_left 0
  @color_white %{r: 245, g: 245, b: 245, a: 255}
  @color_gray %{r: 130, g: 130, b: 130, a: 255}
  @color_red %{r: 230, g: 41, b: 55, a: 255}
  @color_green_a %{r: 0, g: 228, b: 48, a: 126}

  def run do
    init_window(700, 700, "scale rectangle example")
    set_target_fps(60)

    game_loop()
  end

  defp game_loop(
        %{rec: rec, should_scale?: should_scale?} = state \\ %{
          rec: %{x: 100.0, y: 100.0, width: 200.0, height: 80.0},
          should_scale?: false
        }
      ) do
    #
    # update states
    #
    mouse = get_mouse_position()

    # get if rec should scale
    should_scale? =
      (mouse_scale_ready?(mouse, rec) && mouse_button_pressed?(@mouse_left)) ||
        (should_scale? && not mouse_button_released?(@mouse_left))

    # get new size of rec (or current)
    rec = (should_scale? && scale_rec(mouse, rec)) || rec

    # update state
    state = %{
      state
      | rec: rec,
        should_scale?: should_scale?
    }

    Logger.debug("state: #{inspect(state, pretty: true)}")
    Logger.debug("mouse: #{inspect(mouse, pretty: true)}")

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
    #
    # end draw
    #

    (window_should_close() && close_window()) || game_loop(state)
  end

  defp mouse_scale_ready?(mouse, rec) do
    border_rec = %{
      x: rec.x + rec.width - @mouse_mark_size,
      y: rec.y + rec.height - @mouse_mark_size,
      width: @mouse_mark_size,
      height: @mouse_mark_size
    }

    check_collision_point_rec(mouse, rec) and check_collision_point_rec(mouse, border_rec)
  end

  defp scale_rec(mouse, rec) do
    rec = %{rec | width: mouse.x - rec.x, height: mouse.y - rec.y}

    # min size limit
    rec = (rec.width < @mouse_mark_size && %{rec | width: @mouse_mark_size}) || rec
    (rec.height < @mouse_mark_size && %{rec | height: @mouse_mark_size}) || rec
  end
end
