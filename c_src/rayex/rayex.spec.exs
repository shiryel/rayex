# Follows this refsheet:
# https://www.raylib.com/cheatsheet/cheatsheet.html

module Rayex

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

# Cursor-related functions

# Drawing-related functions
spec begin_drawing() :: :ok :: label
spec end_drawing() :: :ok :: label

# VR stereo config functions for VR simulator

# Shader management functions
# NOTE: Shader functionality is not available on OpenGL 1.1

# Screen-space-related functions

# Timing-related functions

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

# Input-related functions: touch

# Gestures and Touch Handling Functions (Module: rgestures)

# Camera System Functions (Module: rcamera)

##########
# SHAPES #
##########

# Set texture and rectangle to be used on shapes drawing
# NOTE: It can be useful when using basic shapes and one single font,
# defining a font char white rectangle would allow drawing everything in a single draw call
spec set_shapes_texture(texture :: texture_2d, source :: rectangle) :: :ok :: label

spec draw_pixel(x :: int, y :: int, color :: color) :: :ok :: label
spec draw_line(start_x :: int, start_y :: int, end_x :: int, end_y :: int, color :: color) :: :ok :: label

# Basic shapes drawing functions

# Basic shapes collision detection functions

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

# Text misc. functions

# Text codepoints management functions (unicode characters)

# Text strings management functions (no utf8 strings, only byte chars)         
# NOTE: Some strings allocate memory internally for returned strings, just be careful!

##########
# MODELS #
##########

# Basic geometric 3D shapes drawing functions

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

# Wave/Sound loading/unloading functions

# Wave/Sound management functions

# Music management functions

# AudioStream management functions

###########
# STRUCTS #
###########
# https://github.com/raysan5/raylib/blob/master/src/raylib.h

type vector2 :: %Vector2{
  x: float,
  y: float
}

type vector3 :: %Vector3{
  x: float,
  y: float,
  z: float
}

type vector4 :: %Vector4{
  x: float,
  y: float,
  z: float,
  w: float
}

# same as vector4
type quaternion :: %Quaternion{
  x: float,
  y: float,
  z: float,
  w: float
}

type matrix :: %Matrix{
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

type color :: %Color{
  r: unsigned,
  g: unsigned,
  b: unsigned,
  a: unsigned
}

type rectangle :: %Rectangle{
  x: float,
  y: float,
  width: float,
  height: float
}

type image :: %Image{
  # XXX: verify if payload works as a void*
  # take a look at https://hexdocs.pm/unifex/Unifex.Specs.DSL.html#spec/1-parameters
  data: payload,
  width: int,
  height: int,
  mipmaps: int,
  format: int
}

type texture :: %Texture{
  id: unsigned,
  width: float,
  height: float,
  mipmaps: int,
  format: int
}

# same as Texture
type texture_2d :: %Texture2D{
  id: unsigned,
  width: float,
  height: float,
  mipmaps: int,
  format: int
}

# same as Texture
type texture_cubemap :: %TextureCubemap{
  id: unsigned,
  width: float,
  height: float,
  mipmaps: int,
  format: int
}

type render_texture :: %RenderTexture{
  id: unsigned,
  texture: texture,
  depth: texture
}

# same as render_texture
type render_texture_2d :: %RenderTexture2D{
  id: unsigned,
  texture: texture,
  depth: texture
}

type n_patch_info :: %NPatchInfo{
  source: rectangle,
  left: int,
  top: int,
  right: int,
  bottom: int,
  layout: int
}

type glyph_info :: %GlyphInfo{
  value: int,
  offsetX: int,
  offsetY: int,
  advanceX: int,
  image: image
}

type font :: %Font{
  baseSize: int,
  glyphCount: int,
  glyphPadding: int,
  texture: texture,
  recs: [rectangle],
  glyphs: [glyph_info]
}

type camera_3d :: %Camera3D{
  position: vector3,
  target: vector3,
  up: vector3,
  fovy: float,
  projection: int,
}

type camera_2d :: %Camera2D{
  offset: vector2,
  target: vector2,
  rotation: float,
  zoom: float,
}

type mesh :: %Mesh{
  vertexCount: int,
  triangleCount: int,

  # Vertex attributes data
  vertices: [float],
  texcoords: [float],
  texcoords2: [float],
  normals: [float],
  tangents: [float],
  colors: [unsigned],
  indices: [unsigned],

  # Animation vertex data
  animVertices: [float],
  animNormals: [float],
  boneIds: [unsigned],
  boneWeights: [float],

  # OpenGL identifiers
  vaoId: [unsigned],
  vboId: [unsigned]
}

type shader :: %Shader{
  id: unsigned,
  locs: [int]
}

type material_map :: %MaterialMap{
  texture: texture_2d,
  color: color,
  value: float
}

type material :: %Material{
  shader: shader,
  maps: [material_map],
  params: [float]
}

type transform :: %Transform{
  translation: vector3,
  rotation: quaternion,
  scale: vector3
}

type bone_info :: %BoneInfo{
  name: string,
  parent: int
}

type model :: %Model{
  transform: matrix,

  meshCount: int,
  materialCount: int,
  mashes: [mesh],
  materials: [material],
  meshMaterial: [int],

  boneCount: int,
  bones: [bone_info],
  bindPose: [transform]
}

type model_animation :: %ModelAnimation{
  boneCount: int,
  frameCount: int,
  bones: [bone_info],
  # XXX: should be **transform
  framePoses: [transform]
}

type ray :: %Ray{
  position: vector3,
  direction: vector3
}

type ray_collision :: %RayCollision{
  hit: bool,
  distance: float,
  point: vector3,
  normal: vector3
}

type bounding_box :: %BoundingBox{
  min: vector3,
  max: vector3
}

type wave :: %Wave{
  frameCount: unsigned,
  sampleRate: unsigned,
  sampleSize: unsigned,
  channels: unsigned,
  data: payload,
}

# FIXME: ? https://github.com/raysan5/raylib/blob/master/src/raylib.h#L428
type r_audio_buffer :: %RAudioBuffer{}

type audio_stream :: %AudioStream{
  buffer: [r_audio_buffer],

  sampleRate: unsigned,
  sampleSize: unsigned,
  channels: unsigned
}

type sound :: %Sound{
  stream: audio_stream,
  frameCount: unsigned
}

type music :: %Music{
  stream: audio_stream,
  frameCount: unsigned,
  looping: bool,

  ctxType: int,
  ctxData: payload
}

type vr_device_info :: %VrDeviceInfo{
  hResolution: int,
  vResolution: int,
  hScreenSize: float,
  vScreenSize: float,
  vScreenCenter: float,
  eyeToScreenDistance: float,
  lensSeparationDistance: float,
  interpupillaryDistance: float,
  lensDistortionValues: [float],
  chromaAbCorrection: [float]
}

type vr_stereo_config :: %VrStereoConfig{
  projection: [matrix],
  viewOffset: [matrix],
  leftLensCenter: [float],
  rightLensCenter: [float],
  leftScreenCenter: [float],
  rightScreenCenter: [float],
  scale: [float],
  scaleIn: [float]
}
