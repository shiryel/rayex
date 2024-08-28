defmodule Rayex.Audio do
  @moduledoc """
    Audio related functions
  """

  alias Rayex.Structs, as: S
  alias Rayex.Unifex.Raylib

  # Audio device management functions

  @doc "Initialize audio device and context"
  @spec init_audio_device() :: :ok
  defdelegate init_audio_device(), to: Raylib

  @doc "Check if audio device has been initialized successfully"
  @spec is_audio_device_ready?() :: boolean()
  defdelegate is_audio_device_ready?(), to: Raylib, as: :is_audio_device_ready

  @doc "Set master volume (listener)"
  @spec set_master_volume(float()) :: :ok
  defdelegate set_master_volume(volume), to: Raylib

  # Wave/Sound loading/unloading functions

  @doc "Load sound from file"
  @spec load_sound(String.t()) :: S.Sound.t()
  defdelegate load_sound(fileName), to: Raylib

  @doc "Checks if a sound is ready"
  @spec is_sound_ready?(S.Sound.t()) :: boolean()
  defdelegate is_sound_ready?(sound), to: Raylib, as: :is_sound_ready

  # Wave/Sound management functions

  @doc "Play a sound"
  @spec play_sound(S.Sound.t()) :: :ok
  defdelegate play_sound(sound), to: Raylib

  @doc "Stop a sound"
  @spec stop_sound(S.Sound.t()) :: :ok
  defdelegate stop_sound(sound), to: Raylib

  # Music management functions

  # AudioStream management functions
end
