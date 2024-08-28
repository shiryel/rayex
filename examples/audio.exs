#!elixir

Mix.install([
  {:rayex, path: ".."}
])

defmodule Test do
  @moduledoc false

  alias Rayex.Structs, as: S

  use Rayex
  use Rayex.Keys

  @camera_first_person 4
  @color_white %S.Color{r: 245, g: 245, b: 245, a: 255}
  @color_darkgray %S.Color{r: 80, g: 80, b: 80, a: 255}

  def run do
    init_window(800, 450, "raylib [core] example - 3d picking")
    set_target_fps(60)

    camera = %S.Camera3D{
      position: %S.Vector3{x: 6.0, y: 6.0, z: 6.0},
      target: %S.Vector3{x: 0.0, y: 2.0, z: 0.0},
      up: %S.Vector3{x: 0.0, y: 1.0, z: 0.0},
      fovy: 45.0,
      # perspective projection
      projection: 0
    }

    camera = update_camera(camera, @camera_first_person)
    init_audio_device()
    sound = load_sound("resources/audio/country.mp3")
    play_sound(sound)

    game_loop(%{camera: camera, sound: sound, pause: false})
  end

  defp game_loop(%{camera: camera, sound: sound, pause: pause} = state) do
    camera = update_camera(camera, @camera_first_person)

    pause =
      if is_key_pressed?(key_space()) do
        (!pause && stop_sound(sound)) || play_sound(sound)
        !pause
      else
        pause
      end

    state = draw(%{state | camera: camera, pause: pause})

    (window_should_close() && close_window()) || game_loop(state)
  end

  defp draw(%{camera: camera} = state) do
    begin_drawing()
    clear_background(@color_white)

    # --- 3D ---
    begin_mode_3d(camera)

    draw_grid(10, 1.0)

    end_mode_3d()
    # --- 3D ---

    draw_text("PRESS SPACE TO PAUSE/RESUME MUSIC", 200, 10, 20, @color_darkgray)
    draw_fps(10, 10)

    end_drawing()

    state
  end
end

Test.run()
