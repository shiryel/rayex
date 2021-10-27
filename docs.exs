alias Rayex.{Audio, Core, Models, Shapes, Structs, Text, Textures}

[
  main: "readme",
  extras: [
    "README.md"
  ],
  source_url: "https://github.com/shiryel/rayex",
  nest_modules_by_prefix: [
    Rayex,
    Structs
  ],
  groups_for_modules: [
    Rayex: [
      Rayex,
      Core,
      Shapes,
      Textures,
      Text,
      Models,
      Audio
    ],
    Structs: [
      Structs.AudioStream,
      Structs.BoneInfo,
      Structs.BoundingBox,
      Structs.Camera2D,
      Structs.Camera3D,
      Structs.Color,
      Structs.Font,
      Structs.GlyphInfo,
      Structs.Image,
      Structs.Material,
      Structs.MaterialMap,
      Structs.Matrix,
      Structs.Mesh,
      Structs.Model,
      Structs.ModelAnimation,
      Structs.Music,
      Structs.NPatchInfo,
      Structs.Quaternion,
      Structs.RAudioBuffer,
      Structs.Ray,
      Structs.RayCollision,
      Structs.Rectangle,
      Structs.RenderTexture,
      Structs.RenderTexture2D,
      Structs.Shader,
      Structs.Sound,
      Structs.Texture2D,
      Structs.TextureCubemap,
      Structs.Transform,
      Structs.Vector2,
      Structs.Vector3,
      Structs.Vector4,
      Structs.VrDeviceInfo,
      Structs.VrStereoConfig,
      Structs.Wave
    ]
  ]
]
