defmodule Rayex.Structs.Vector2 do
  @moduledoc "Vector2"
  @enforce_keys ~w[x y]a
  defstruct ~w[x y]a

  @type t :: %__MODULE__{x: float(), y: float()}
end

defmodule Rayex.Structs.Vector3 do
  @moduledoc "Vector3"
  @enforce_keys ~w[x y z]a
  defstruct ~w[x y z]a

  @type t :: %__MODULE__{x: float(), y: float(), z: float()}
end

defmodule Rayex.Structs.Vector4 do
  @moduledoc "Vector3"
  @enforce_keys ~w[x y z w]a
  defstruct ~w[x y z w]a

  @type t :: %__MODULE__{x: float(), y: float(), z: float(), w: float()}
end

# same as vector4
defmodule Rayex.Structs.Quaternion do
  @moduledoc "Quaternion"
  @enforce_keys ~w[x y z w]a
  defstruct ~w[x y z w]a

  @type t :: %__MODULE__{x: float(), y: float(), z: float(), w: float()}
end

defmodule Rayex.Structs.Matrix do
  @moduledoc "Matrix"
  @enforce_keys ~w[m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15]a
  defstruct ~w[m0 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 m13 m14 m15]a

  @type t :: %__MODULE__{
          m0: float,
          m1: float,
          m2: float,
          m3: float,
          #
          m4: float,
          m5: float,
          m6: float,
          m7: float,
          #
          m8: float,
          m9: float,
          m10: float,
          m11: float,
          #
          m12: float,
          m13: float,
          m14: float,
          m15: float
        }
end

defmodule Rayex.Structs.Color do
  @moduledoc "Color"
  @enforce_keys ~w[r g b a]a
  defstruct ~w[r g b a]a

  @type t :: %__MODULE__{r: pos_integer, g: pos_integer, b: pos_integer, a: pos_integer}
end

defmodule Rayex.Structs.Rectangle do
  @moduledoc "Rectangle"
  @enforce_keys ~w[x y width height]a
  defstruct ~w[x y width height]a

  @type t :: %__MODULE__{x: float, y: float, width: float, height: float}
end

defmodule Rayex.Structs.Image do
  @moduledoc "Image"
  # XXX: verify if binary works as a void*
  # take a look at https://hexdocs.pm/unifex/Unifex.Specs.DSL.html#spec/1-parameters
  @enforce_keys ~w[data width height mipmaps format]a
  defstruct ~w[data width height mipmaps format]a

  @type t :: %__MODULE__{
          data: binary(),
          width: integer(),
          height: integer(),
          mipmaps: integer(),
          format: integer()
        }
end

defmodule Rayex.Structs.Texture2D do
  @moduledoc "Texture2D"
  @enforce_keys ~w[id width height mipmaps format]a
  defstruct ~w[id width height mipmaps format]a

  @type t :: %__MODULE__{
          id: pos_integer(),
          width: float(),
          height: float(),
          mipmaps: integer(),
          format: integer()
        }
end

# same as Texture
defmodule Rayex.Structs.TextureCubemap do
  @moduledoc "Texture"
  @enforce_keys ~w[id width height mipmaps format]a
  defstruct ~w[id width height mipmaps format]a

  @type t :: %__MODULE__{
          id: pos_integer(),
          width: float(),
          height: float(),
          mipmaps: integer(),
          format: integer()
        }
end

defmodule Rayex.Structs.RenderTexture do
  @moduledoc "RenderTexture"
  @enforce_keys ~w[id texture depth]a
  defstruct ~w[id texture depth]a

  @type t :: %__MODULE__{
          id: pos_integer,
          texture: Rayex.Structs.Texture2D.t(),
          depth: Rayex.Structs.Texture2D.t()
        }
end

# same as render_texture
defmodule Rayex.Structs.RenderTexture2D do
  @moduledoc "RenderTexture2D"
  @enforce_keys ~w[id texture depth]a
  defstruct ~w[id texture depth]a

  @type t :: %__MODULE__{
          id: pos_integer(),
          texture: Rayex.Structs.Texture2D.t(),
          depth: Rayex.Structs.Texture2D.t()
        }
end

defmodule Rayex.Structs.NPatchInfo do
  @moduledoc "NPatchInfo"
  @enforce_keys ~w[source left top right bottom layout]a
  defstruct ~w[source left top right bottom layout]a

  @type t :: %__MODULE__{
          source: Rayex.Structs.Rectangle.t(),
          left: integer,
          top: integer,
          right: integer,
          bottom: integer,
          layout: integer
        }
end

defmodule Rayex.Structs.GlyphInfo do
  @moduledoc "GlyphInfo"
  @enforce_keys ~w[value offset_x offset_y advance_x image]a
  defstruct ~w[value offset_x offset_y advance_x image]a

  @type t :: %__MODULE__{
          value: integer,
          offset_x: integer,
          offset_y: integer,
          advance_x: integer,
          image: Rayex.Structs.Image.t()
        }
end

defmodule Rayex.Structs.Font do
  @moduledoc "Font"
  @enforce_keys ~w[base_size glyph_count glyph_padding texture recs glyphs]a
  defstruct ~w[base_size glyph_count glyph_padding texture recs glyphs]a

  @type t :: %__MODULE__{
          base_size: integer,
          glyph_count: integer,
          glyph_padding: integer,
          texture: Rayex.Structs.Texture2D.t(),
          recs: [Rayex.Structs.Rectangle.t()],
          glyphs: [Rayex.Structs.GlyphInfo.t()]
        }
end

defmodule Rayex.Structs.Camera3D do
  @moduledoc "Camera3D"
  @enforce_keys ~w[position target up fovy projection]a
  defstruct ~w[position target up fovy projection]a

  @type t :: %__MODULE__{
          position: Rayex.Structs.Vector3.t(),
          target: Rayex.Structs.Vector3.t(),
          up: Rayex.Structs.Vector3.t(),
          fovy: float(),
          projection: integer()
        }
end

defmodule Rayex.Structs.Camera2D do
  @moduledoc "Camera2D"
  @enforce_keys ~w[offset target rotation zoom]a
  defstruct ~w[offset target rotation zoom]a

  @type t :: %__MODULE__{
          offset: Rayex.Structs.Vector2.t(),
          target: Rayex.Structs.Vector2.t(),
          rotation: float,
          zoom: float
        }
end

defmodule Rayex.Structs.Mesh do
  @moduledoc "Mesh"
  @enforce_keys ~w[vertex_count triangle_count vertices texcoords texcoords2
    normals tangents colors indices anim_vertices anim_normals bone_ids
    bone_weights vao_id vbo_id]a
  defstruct ~w[vertex_count triangle_count vertices texcoords texcoords2 normals
    tangents colors indices anim_vertices anim_normals bone_ids bone_weights
    vao_id vbo_id]a

  @type t :: %__MODULE__{
          vertex_count: integer,
          triangle_count: integer,

          # Vertex attributes data
          vertices: [float],
          texcoords: [float],
          texcoords2: [float],
          normals: [float],
          tangents: [float],
          colors: [pos_integer],
          indices: [pos_integer],

          # Animation vertex data
          anim_vertices: [float],
          anim_normals: [float],
          bone_ids: [pos_integer],
          bone_weights: [float],

          # OpenGL identifiers
          vao_id: [pos_integer],
          vbo_id: [pos_integer]
        }
end

defmodule Rayex.Structs.Shader do
  @moduledoc "Shader"
  @enforce_keys ~w[id locs]a
  defstruct ~w[id locs]a

  @type t :: %__MODULE__{
          id: pos_integer(),
          locs: [integer()]
        }
end

defmodule Rayex.Structs.MaterialMap do
  @moduledoc "MaterialMap"
  @enforce_keys ~w[texture color value]a
  defstruct ~w[texture color value]a

  @type t :: %__MODULE__{
          texture: Rayex.Structs.Texture2D.t(),
          color: Rayex.Structs.Color.t(),
          value: float
        }
end

defmodule Rayex.Structs.Material do
  @moduledoc "Material"
  @enforce_keys ~w[shader maps params]a
  defstruct ~w[shader maps params]a

  @type t :: %__MODULE__{
          shader: Rayex.Structs.Shader.t(),
          maps: [Rayex.Structs.MaterialMap.t()],
          params: [float]
        }
end

defmodule Rayex.Structs.Transform do
  @moduledoc "Transform"
  @enforce_keys ~w[translation rotation scale]a
  defstruct ~w[translation rotation scale]a

  @type t :: %__MODULE__{
          translation: Rayex.Structs.Vector3.t(),
          rotation: Rayex.Structs.Quaternion.t(),
          scale: Rayex.Structs.Vector3.t()
        }
end

defmodule Rayex.Structs.BoneInfo do
  @moduledoc "BoneInfo"
  @enforce_keys ~w[name parent]a
  defstruct ~w[name parent]a

  @type t :: %__MODULE__{
          name: String.t(),
          parent: integer()
        }
end

defmodule Rayex.Structs.Model do
  @moduledoc "Model"
  @enforce_keys ~w[transform mesh_count material_count mashes materials mesh_material bone_count bones bind_pose]a
  defstruct ~w[transform mesh_count material_count mashes materials mesh_material bone_count bones bind_pose]a

  @type t :: %__MODULE__{
          transform: Rayex.Structs.Matrix.t(),
          mesh_count: integer(),
          material_count: integer(),
          mashes: [Rayex.Structs.Mesh.t()],
          materials: [Rayex.Structs.Material.t()],
          mesh_material: [integer()],
          bone_count: integer(),
          bones: [Rayex.Structs.BoneInfo.t()],
          bind_pose: [Rayex.Structs.Transform.t()]
        }
end

defmodule Rayex.Structs.ModelAnimation do
  @moduledoc "ModelAnimation"
  @enforce_keys ~w[bone_count frame_count bones frame_poses]a
  defstruct ~w[bone_count frame_count bones frame_poses]a

  @type t :: %__MODULE__{
          bone_count: integer(),
          frame_count: integer(),
          bones: [Rayex.Structs.BoneInfo.t()],
          # XXX: should be **transform
          frame_poses: [[Rayex.Structs.Transform.t()]]
        }
end

defmodule Rayex.Structs.Ray do
  @moduledoc "Ray"
  @enforce_keys ~w[position direction]a
  defstruct ~w[position direction]a

  @type t :: %__MODULE__{
          position: Rayex.Structs.Vector3.t(),
          direction: Rayex.Structs.Vector3.t()
        }
end

defmodule Rayex.Structs.RayCollision do
  @moduledoc "RayCollision"
  @enforce_keys ~w[hit distance point normal]a
  defstruct ~w[hit distance point normal]a

  @type t :: %__MODULE__{
          hit: boolean(),
          distance: float,
          point: Rayex.Structs.Vector3.t(),
          normal: Rayex.Structs.Vector3.t()
        }
end

defmodule Rayex.Structs.BoundingBox do
  @moduledoc "BoundingBox"
  @enforce_keys ~w[min max]a
  defstruct ~w[min max]a

  @type t :: %__MODULE__{
          min: Rayex.Structs.Vector3.t(),
          max: Rayex.Structs.Vector3.t()
        }
end

defmodule Rayex.Structs.Wave do
  @moduledoc "Wave"
  @enforce_keys ~w[frame_count sample_rate sample_size channels data]a
  defstruct ~w[frame_count sample_rate sample_size channels data]a

  @type t :: %__MODULE__{
          frame_count: pos_integer(),
          sample_rate: pos_integer(),
          sample_size: pos_integer(),
          channels: pos_integer(),
          data: binary()
        }
end

# XXX: ? https://github.com/raysan5/raylib/blob/master/src/raylib.h#L428
defmodule Rayex.Structs.RAudioBuffer do
  @moduledoc "RAudioBuffer"
  @enforce_keys ~w[]a
  defstruct ~w[]a

  @type t :: %__MODULE__{}
end

defmodule Rayex.Structs.AudioStream do
  @moduledoc "AudioStream"
  @enforce_keys ~w[buffer sample_rate sample_size channels]a
  defstruct ~w[buffer sample_rate sample_size channels]a

  @type t :: %__MODULE__{
          buffer: [Rayex.Structs.RAudioBuffer.t()],
          sample_rate: pos_integer(),
          sample_size: pos_integer(),
          channels: pos_integer()
        }
end

defmodule Rayex.Structs.Sound do
  @moduledoc "Sound"
  @enforce_keys ~w[stream frame_count]a
  defstruct ~w[stream frame_count]a

  @type t :: %__MODULE__{
          stream: Rayex.Structs.AudioStream.t(),
          frame_count: pos_integer()
        }
end

defmodule Rayex.Structs.Music do
  @moduledoc "Music"
  @enforce_keys ~w[stream frame_count looping ctx_type ctx_data]a
  defstruct ~w[stream frame_count looping ctx_type ctx_data]a

  @type t :: %__MODULE__{
          stream: Rayex.Structs.AudioStream.t(),
          frame_count: pos_integer(),
          looping: boolean(),
          ctx_type: integer(),
          ctx_data: binary()
        }
end

defmodule Rayex.Structs.VrDeviceInfo do
  @moduledoc "VrDeviceInfo"
  @enforce_keys ~w[h_resolution v_resolution h_screen_size v_screen_size
    v_screen_center eye_to_screen_distance lens_separation_distance
    interpupillary_distance lens_distortion_values chroma_ab_correction]a
  defstruct ~w[h_resolution v_resolution h_screen_size v_screen_size
    v_screen_center eye_to_screen_distance lens_separation_distance
    interpupillary_distance lens_distortion_values chroma_ab_correction]a

  @type t :: %__MODULE__{
          h_resolution: integer(),
          v_resolution: integer(),
          h_screen_size: float,
          v_screen_size: float,
          v_screen_center: float,
          eye_to_screen_distance: float,
          lens_separation_distance: float,
          interpupillary_distance: float,
          lens_distortion_values: [float],
          chroma_ab_correction: [float]
        }
end

defmodule Rayex.Structs.VrStereoConfig do
  @moduledoc "VrStereoConfig"
  @enforce_keys ~w[projection view_offset left_lens_center right_lens_center
    left_screen_center right_screen_center scale scale_in]a
  defstruct ~w[projection view_offset left_lens_center right_lens_center
    left_screen_center right_screen_center scale scale_in]a

  @type t :: %__MODULE__{
          projection: [Rayex.Structs.Matrix.t()],
          view_offset: [Rayex.Structs.Matrix.t()],
          left_lens_center: [float],
          right_lens_center: [float],
          left_screen_center: [float],
          right_screen_center: [float],
          scale: [float],
          scale_in: [float]
        }
end
