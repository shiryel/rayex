defmodule Rayex.Core do
  @moduledoc """
    Main functions
  """

  alias Rayex.Structs, as: S
  alias Rayex.Unifex.Raylib

  # Window-related functions

  @doc "Initialize window and OpenGL context"
  @spec init_window(integer(), integer(), String.t()) :: :ok
  defdelegate init_window(width, height, title), to: Raylib

  @doc "Check if KEY_ESCAPE pressed or Close icon pressed"
  @spec window_should_close() :: boolean()
  defdelegate window_should_close, to: Raylib

  @doc "Close window and unload OpenGL context"
  @spec close_window() :: :ok
  defdelegate close_window, to: Raylib

  @doc "Check if window has been initialized successfully"
  @spec window_ready?() :: boolean()
  defdelegate window_ready?, to: Raylib, as: :is_window_ready

  @doc "Check if window is currently fullscreen"
  @spec window_fullscreen?() :: boolean()
  defdelegate window_fullscreen?, to: Raylib, as: :is_window_fullscreen

  @doc "Check if window is currently hidden (only PLATFORM_DESKTOP)"
  @spec window_hidden?() :: boolean()
  defdelegate window_hidden?, to: Raylib, as: :is_window_hidden

  @doc "Check if window is currently minimized (only PLATFORM_DESKTOP)"
  @spec window_minimized?() :: boolean()
  defdelegate window_minimized?, to: Raylib, as: :is_window_minimized

  @doc "Check if window is currently maximized (only PLATFORM_DESKTOP)"
  @spec window_maximized?() :: boolean()
  defdelegate window_maximized?, to: Raylib, as: :is_window_maximized

  @doc "Check if window is currently focused (only PLATFORM_DESKTOP)"
  @spec window_focused?() :: boolean()
  defdelegate window_focused?, to: Raylib, as: :is_window_focused

  @doc "Check if window has been resized last frame"
  @spec window_resized?() :: boolean()
  defdelegate window_resized?, to: Raylib, as: :is_window_resized

  @doc "Check if one specific window flag is enabled"
  @spec window_state?(non_neg_integer()) :: boolean()
  defdelegate window_state?(flag), to: Raylib, as: :is_window_state

  @doc "Set window configuration state using flags"
  @spec set_window_state(non_neg_integer()) :: :ok
  defdelegate set_window_state(flag), to: Raylib

  @doc "Clear window configuration state flags"
  @spec clear_window_state(non_neg_integer()) :: :ok
  defdelegate clear_window_state(flag), to: Raylib

  @doc "Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)"
  @spec toggle_fullscreen() :: :ok
  defdelegate toggle_fullscreen, to: Raylib

  # Cursor-related functions

  # Drawing-related functions

  @doc "Set background color (framebuffer clear color)"
  @spec clear_background(S.Color.t()) :: :ok
  defdelegate clear_background(color), to: Raylib

  @doc "Setup canvas (framebuffer) to start drawing"
  @spec begin_drawing() :: :ok
  defdelegate begin_drawing, to: Raylib

  @doc "End canvas drawing and swap buffers (double buffering)"
  @spec end_drawing() :: :ok
  defdelegate end_drawing, to: Raylib

  # VR stereo config functions for VR simulator

  # Shader management functions
  # NOTE: Shader functionality is not available on OpenGL 1.1

  # Screen-space-related functions
  @doc "Get a ray trace from mouse position"
  @spec get_mouse_ray(S.Vector2.t(), S.Camera3D.t()) :: S.Ray.t()
  defdelegate get_mouse_ray(mouse_position, camera), to: Raylib

  @doc "Begin 2D mode with custom camera (2D)"
  @spec begin_mode_2d(S.Camera2D.t()) :: :ok
  defdelegate begin_mode_2d(camera_2d), to: Raylib

  @doc "Ends 2D mode with custom camera"
  @spec end_mode_2d() :: :ok
  defdelegate end_mode_2d, to: Raylib

  @doc "Begin 3D mode with custom camera (3D)"
  @spec begin_mode_3d(S.Camera3D.t()) :: :ok
  defdelegate begin_mode_3d(camera_3d), to: Raylib

  @doc "Ends 3D mode and returns to default 2D orthographic mode"
  @spec end_mode_3d() :: :ok
  defdelegate end_mode_3d, to: Raylib

  # Timing-related functions

  @doc "Set target FPS (maximum)"
  @spec set_target_fps(non_neg_integer()) :: :ok
  defdelegate set_target_fps(fps), to: Raylib

  @doc "Get current FPS"
  @spec get_fps() :: non_neg_integer()
  defdelegate get_fps, to: Raylib

  @doc "Get time in seconds for last frame drawn (delta time)"
  @spec get_frame_time() :: float()
  defdelegate get_frame_time, to: Raylib

  @doc "Get elapsed time in seconds since `init_window/0`"
  @spec get_time() :: float()
  defdelegate get_time, to: Raylib

  # Misc. functions

  # Set custom callbacks
  # WARNING: Callbacks setup is intended for advance users

  # Files management functions

  # Compression/Encoding functionality

  # Persistent storage management

  # Misc.

  # Input-related functions: keyboard

  # Input-related functions: gamepads

  # Input-related functions: mouse

  @doc "Check if a mouse button has been pressed once"
  @spec mouse_button_pressed?(integer()) :: boolean()
  defdelegate mouse_button_pressed?(button), to: Raylib, as: :is_mouse_button_pressed

  @doc "Check if a mouse button is being pressed"
  @spec mouse_button_down?(integer()) :: boolean()
  defdelegate mouse_button_down?(button), to: Raylib, as: :is_mouse_button_down

  @doc "Check if a mouse button has been released once"
  @spec mouse_button_released?(integer()) :: boolean()
  defdelegate mouse_button_released?(button), to: Raylib, as: :is_mouse_button_released

  @doc "Check if a mouse button is NOT being pressed"
  @spec mouse_button_up?(integer()) :: boolean()
  defdelegate mouse_button_up?(button), to: Raylib, as: :is_mouse_button_up

  @doc "Get mouse position XY"
  @spec get_mouse_position() :: S.Vector2.t()
  defdelegate get_mouse_position, to: Raylib

  # Input-related functions: touch

  # Gestures and Touch Handling Functions (Module: rgestures)

  # Camera System Functions (Module: rcamera)

  @doc "Update camera position for selected mode"
  @spec update_camera(S.Camera3D.t(), integer()) :: :ok
  defdelegate update_camera(camera_3d, mode), to: Raylib

  @doc "Update camera movement/rotation"
  @spec update_camera_pro(S.Camera3D.t(), S.Vector3.t(), S.Vector3.t(), float()) :: :ok
  defdelegate update_camera_pro(camera_3d, movement, rotation, zoom), to: Raylib
end
