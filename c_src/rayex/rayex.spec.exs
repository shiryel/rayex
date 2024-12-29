# Follows this refsheet:
# https://www.raylib.com/cheatsheet/cheatsheet.html

module Rayex.Unifex.Raylib

interface [NIF, CNode]

########
# CORE #
########

# Window-related functions
spec init_window(width :: int, height :: int, title :: string) :: :ok :: label
spec window_should_close() :: result :: bool
spec close_window() :: :ok :: label
spec is_window_ready() :: result :: bool
spec is_window_fullscreen() :: result :: bool
spec is_window_hidden() :: result :: bool
spec is_window_minimized() :: result :: bool
spec is_window_maximized() :: result :: bool
spec is_window_focused() :: result :: bool
spec is_window_resized() :: result :: bool
spec is_window_state(flag :: int) :: result :: bool
spec set_window_state(flag :: int) :: :ok :: label
spec clear_window_state(flag :: int) :: :ok :: label
spec toggle_fullscreen() :: :ok :: label
spec get_screen_width() :: result :: int
spec get_screen_height() :: result :: int

# Cursor-related functions

spec show_cursor() :: :ok :: label
spec hide_cursor() :: :ok :: label
spec is_cursor_hidden() :: result :: bool
spec enable_cursor() :: :ok :: label
spec disable_cursor() :: :ok :: label
spec is_cursor_on_screen() :: result :: bool

# Drawing-related functions
spec clear_background(color :: color) :: :ok :: label
spec begin_drawing() :: :ok :: label
spec end_drawing() :: :ok :: label
spec begin_mode_2d(camera_2d :: camera_2d) :: :ok :: label
spec end_mode_2d() :: :ok :: label
spec begin_mode_3d(camera_3d :: camera_3d) :: :ok :: label
spec end_mode_3d() :: :ok :: label

# VR stereo config functions for VR simulator

# Shader management functions
# NOTE: Shader functionality is not available on OpenGL 1.1

# Screen-space-related functions
spec get_mouse_ray(mouse_position :: vector2, camera :: camera_3d) :: ray :: ray

# Timing-related functions
spec set_target_fps(fps :: int) :: :ok :: label
spec get_fps() :: fps :: int
spec get_frame_time() :: delta :: float
spec get_time() :: time_from_start :: float

# Misc. functions

# Set custom callbacks
# WARNING: Callbacks setup is intended for advance users

# Files management functions

# Compression/Encoding functionality

# Persistent storage management

# Misc.

# Input-related functions: keyboard

spec is_key_pressed(key :: int) :: result :: bool
dirty(:cpu, is_key_pressed: 1)

spec is_key_pressed_repeat(key :: int) :: result :: bool
dirty(:cpu, is_key_pressed_repeat: 1)

spec is_key_down(key :: int) :: result :: bool
dirty(:cpu, is_key_down: 1)

spec is_key_released(key :: int) :: result :: bool
dirty(:cpu, is_key_released: 1)

spec is_key_up(key :: int) :: result :: bool
dirty(:cpu, is_key_up: 1)

spec get_key_pressed() :: key :: int
dirty(:cpu, get_key_pressed: 0)

spec get_char_pressed() :: character :: int
dirty(:cpu, get_char_pressed: 0)

spec set_exit_key(key :: int) :: :ok :: label
dirty(:cpu, set_exit_key: 1)

# Input-related functions: gamepads

# Input-related functions: mouse
spec is_mouse_button_pressed(button :: int) :: result :: bool
spec is_mouse_button_down(button :: int) :: result :: bool
spec is_mouse_button_released(button :: int) :: result :: bool
spec is_mouse_button_up(button :: int) :: result :: bool
spec get_mouse_position() :: xy :: vector2

# Input-related functions: touch

# Gestures and Touch Handling Functions (Module: rgestures)

# Camera System Functions (Module: rcamera)
spec update_camera(camera :: camera_3d, mode :: int) :: camera :: camera_3d

spec update_camera_pro(
       camera :: camera_3d,
       movement :: vector3,
       rotation :: vector3,
       zoom :: float
     ) :: camera :: camera_3d

##########
# SHAPES #
##########

# Set texture and rectangle to be used on shapes drawing
# NOTE: It can be useful when using basic shapes and one single font,
# defining a font char white rectangle would allow drawing everything in a single draw call
spec set_shapes_texture(texture :: texture_2d, source :: rectangle) :: :ok :: label

# Basic shapes drawing functions
spec draw_pixel(x :: int, y :: int, color :: color) :: :ok :: label

spec draw_line(start_x :: int, start_y :: int, end_x :: int, end_y :: int, color :: color) ::
       :ok :: label

spec draw_circle(center_x :: int, center_y :: int, radius :: float, color :: color) :: :ok :: label
spec draw_circle_v(center :: vector2, radius :: float, color :: color) :: :ok :: label
spec draw_rectangle_rec(rec :: rectangle, color :: color) :: :ok :: label
spec draw_rectangle_lines_ex(rec :: rectangle, line_thick :: int, color :: color) :: :ok :: label
spec draw_triangle(v1 :: vector2, v2 :: vector2, v3 :: vector2, color :: color) :: :ok :: label

# Basic shapes collision detection functions
spec check_collision_point_rec(point :: vector2, rec :: rectangle) :: result :: bool
spec get_ray_collision_box(ray :: ray, box :: bounding_box) :: ray_collision :: ray_collision

############
# TEXTURES #
############

# Image loading functions
# NOTE: This functions do not require GPU access

# Image generation functions

# Image manipulation functions

# Image drawing functions
# NOTE: Image software-rendering functions (CPU)

# Texture loading functions
# NOTE: These functions require GPU access

# Texture configuration functions

# Texture drawing functionsc

# Color/pixel related functions

########
# TEXT #
########

# Font loading/unloading functions

# Text drawing functions
spec draw_fps(pos_x :: int, pos_y :: int) :: :ok :: label

spec draw_text(text :: string, pos_x :: int, pos_y :: int, font_size :: int, color :: color) ::
       :ok :: label

# Text misc. functions

# Text codepoints management functions (unicode characters)

# Text strings management functions (no utf8 strings, only byte chars)         
# NOTE: Some strings allocate memory internally for returned strings, just be careful!

##########
# MODELS #
##########

# Basic geometric 3D shapes drawing functions
spec draw_cube(
       position :: vector3,
       width :: float,
       height :: float,
       length :: float,
       color :: color
     ) :: :ok :: label

spec draw_cube_wires(
       position :: vector3,
       width :: float,
       height :: float,
       length :: float,
       color :: color
     ) :: :ok :: label

spec draw_ray(ray :: ray, color :: color) :: :ok :: label
spec draw_grid(slices :: int, spacing :: float) :: :ok :: label

# Model loading/unloading functions

# Model drawing functions

# Mesh management functions

# Mesh generation functions

# Material loading/unloading functions

# Model animations loading/unloading functions

# Collision detection functions

#########
# AUDIO #
#########

# Audio device management functions
spec init_audio_device() :: :ok :: label
spec close_audio_device() :: :ok :: label
spec is_audio_device_ready() :: result :: bool
spec set_master_volume(volume :: float) :: :ok :: label
spec get_master_volume() :: volume :: float

# Wave/Sound loading/unloading functions

spec load_sound(file_name :: string) :: sound :: payload
dirty(:io, load_sound: 1)

spec is_sound_ready(sound :: payload) :: result :: bool

# Wave/Sound management functions

spec play_sound(sound :: payload) :: :ok :: label
spec stop_sound(sound :: payload) :: :ok :: label

# Music management functions

# AudioStream management functions

###########
# STRUCTS #
###########
# https://github.com/raysan5/raylib/blob/master/src/raylib.h

type vector2 :: %Rayex.Structs.Vector2{
       x: float,
       y: float
     }

type vector3 :: %Rayex.Structs.Vector3{
       x: float,
       y: float,
       z: float
     }

type vector4 :: %Rayex.Structs.Vector4{
       x: float,
       y: float,
       z: float,
       w: float
     }

# same as vector4
type quaternion :: %Rayex.Structs.Quaternion{
       x: float,
       y: float,
       z: float,
       w: float
     }

type matrix :: %Rayex.Structs.Matrix{
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

type color :: %Rayex.Structs.Color{
       r: unsigned,
       g: unsigned,
       b: unsigned,
       a: unsigned
     }

type rectangle :: %Rayex.Structs.Rectangle{
       x: float,
       y: float,
       width: float,
       height: float
     }

type image :: %Rayex.Structs.Image{
       # XXX: verify if payload works as a void*
       # take a look at https://hexdocs.pm/unifex/Unifex.Specs.DSL.html#spec/1-parameters
       data: payload,
       width: int,
       height: int,
       mipmaps: int,
       format: int
     }

type texture :: %Rayex.Structs.Texture{
       id: unsigned,
       width: float,
       height: float,
       mipmaps: int,
       format: int
     }

# same as Texture
type texture_2d :: %Rayex.Structs.Texture2D{
       id: unsigned,
       width: float,
       height: float,
       mipmaps: int,
       format: int
     }

# same as Texture
type texture_cubemap :: %Rayex.Structs.TextureCubemap{
       id: unsigned,
       width: float,
       height: float,
       mipmaps: int,
       format: int
     }

type render_texture :: %Rayex.Structs.RenderTexture{
       id: unsigned,
       texture: texture,
       depth: texture
     }

# same as render_texture
type render_texture_2d :: %Rayex.Structs.RenderTexture2D{
       id: unsigned,
       texture: texture,
       depth: texture
     }

type n_patch_info :: %Rayex.Structs.NPatchInfo{
       source: rectangle,
       left: int,
       top: int,
       right: int,
       bottom: int,
       layout: int
     }

type glyph_info :: %Rayex.Structs.GlyphInfo{
       value: int,
       offset_x: int,
       offset_y: int,
       advance_x: int,
       image: image
     }

type font :: %Rayex.Structs.Font{
       base_size: int,
       glyph_count: int,
       glyph_padding: int,
       texture: texture,
       recs: [rectangle],
       glyphs: [glyph_info]
     }

type camera_3d :: %Rayex.Structs.Camera3D{
       position: vector3,
       target: vector3,
       up: vector3,
       fovy: float,
       projection: int
     }

type camera_2d :: %Rayex.Structs.Camera2D{
       offset: vector2,
       target: vector2,
       rotation: float,
       zoom: float
     }

type mesh :: %Rayex.Structs.Mesh{
       vertex_count: int,
       triangle_count: int,

       # Vertex attributes data
       vertices: [float],
       texcoords: [float],
       texcoords2: [float],
       normals: [float],
       tangents: [float],
       colors: [unsigned],
       indices: [unsigned],

       # Animation vertex data
       anim_vertices: [float],
       anim_normals: [float],
       bone_ids: [unsigned],
       bone_weights: [float],

       # OpenGL identifiers
       vao_id: [unsigned],
       vbo_id: [unsigned]
     }

type shader :: %Rayex.Structs.Shader{
       id: unsigned,
       locs: [int]
     }

type material_map :: %Rayex.Structs.MaterialMap{
       texture: texture_2d,
       color: color,
       value: float
     }

type material :: %Rayex.Structs.Material{
       shader: shader,
       maps: [material_map],
       params: [float]
     }

type transform :: %Rayex.Structs.Transform{
       translation: vector3,
       rotation: quaternion,
       scale: vector3
     }

type bone_info :: %Rayex.Structs.BoneInfo{
       name: string,
       parent: int
     }

type model :: %Rayex.Structs.Model{
       transform: matrix,
       mesh_count: int,
       material_count: int,
       mashes: [mesh],
       materials: [material],
       mesh_material: [int],
       bone_count: int,
       bones: [bone_info],
       bind_pose: [transform]
     }

type model_animation :: %Rayex.Structs.ModelAnimation{
       bone_count: int,
       frame_count: int,
       bones: [bone_info],
       # XXX: should be **transform
       frame_poses: [transform]
     }

type ray :: %Rayex.Structs.Ray{
       position: vector3,
       direction: vector3
     }

type ray_collision :: %Rayex.Structs.RayCollision{
       hit: bool,
       distance: float,
       point: vector3,
       normal: vector3
     }

type bounding_box :: %Rayex.Structs.BoundingBox{
       min: vector3,
       max: vector3
     }

type wave :: %Rayex.Structs.Wave{
       frame_count: unsigned,
       sample_rate: unsigned,
       sample_size: unsigned,
       channels: unsigned,
       data: payload
     }

# type audio_stream :: %Rayex.Structs.AudioStream{
#       buffer: [r_audio_buffer],
#       processor: [r_audio_processor],
#       sample_rate: unsigned,
#       sample_size: unsigned,
#       channels: unsigned
#     }
#
# type sound :: %Rayex.Structs.Sound{
#       stream: audio_stream,
#       frame_count: unsigned
#     }

type music :: %Rayex.Structs.Music{
       stream: payload,
       frame_count: unsigned,
       looping: bool,
       ctx_type: int,
       ctx_data: payload
     }

type vr_device_info :: %Rayex.Structs.VrDeviceInfo{
       h_resolution: int,
       v_resolution: int,
       h_screen_size: float,
       v_screen_size: float,
       v_screen_center: float,
       eye_to_screen_distance: float,
       lensSeparation_distance: float,
       interpupillary_distance: float,
       lens_distortion_values: [float],
       chroma_ab_correction: [float]
     }

type vr_stereo_config :: %Rayex.Structs.VrStereoConfig{
       projection: [matrix],
       view_offset: [matrix],
       left_lens_center: [float],
       right_lens_center: [float],
       left_screen_center: [float],
       right_screen_center: [float],
       scale: [float],
       scale_in: [float]
     }
