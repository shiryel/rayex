#ifndef RAYEX_STRUCTS
#define RAYEX_STRUCTS

// NOTE: use "E_" when converting from Raylib to a Erlang struct

#define VECTOR2(v) ((Vector2){.x = v.x, .y = v.y})
#define E_VECTOR2(v) ((vector2){.x = v.x, .y = v.y})

#define VECTOR3(v) ((Vector3){.x = v.x, .y = v.y, .z = v.z})
#define E_VECTOR3(v) ((vector3){.x = v.x, .y = v.y, .z = v.z})

#define VECTOR4(v) ((Vector4){.x = v.x, .y = v.y, .z = v.z, .w = v.w})
#define E_VECTOR4(v) ((vector4){.x = v.x, .y = v.y, .z = v.z, .w = v.w})

#define QUATERNION(q) ((Quaternion){.x = q.x, .y = q.y, .z = q.z, .w = q.w})
#define E_QUATERNION(q) ((quaternion){.x = q.x, .y = q.y, .z = q.z, .w = q.w})

#define MATRIX(m)                                                              \
  ((Matrix){.m0 = m.m0,                                                        \
            .m1 = m.m1,                                                        \
            .m2 = m.m2,                                                        \
            .m3 = m.m3,                                                        \
            .m4 = m.m4,                                                        \
            .m5 = m.m5,                                                        \
            .m6 = m.m6,                                                        \
            .m7 = m.m7,                                                        \
            .m8 = m.m8,                                                        \
            .m9 = m.m9,                                                        \
            .m10 = m.m10,                                                      \
            .m11 = m.m11,                                                      \
            .m12 = m.m12,                                                      \
            .m13 = m.m13,                                                      \
            .m14 = m.m14,                                                      \
            .m15 = m.m15})
#define E_MATRIX(m)                                                            \
  ((matrix){.m0 = m.m0,                                                        \
            .m1 = m.m1,                                                        \
            .m2 = m.m2,                                                        \
            .m3 = m.m3,                                                        \
            .m4 = m.m4,                                                        \
            .m5 = m.m5,                                                        \
            .m6 = m.m6,                                                        \
            .m7 = m.m7,                                                        \
            .m8 = m.m8,                                                        \
            .m9 = m.m9,                                                        \
            .m10 = m.m10,                                                      \
            .m11 = m.m11,                                                      \
            .m12 = m.m12,                                                      \
            .m13 = m.m13,                                                      \
            .m14 = m.m14,                                                      \
            .m15 = m.m15})

#define COLOR(c) ((Color){.r = c.r, .g = c.g, .b = c.b, .a = c.a})
#define E_COLOR(c) ((color){.r = c.r, .g = c.g, .b = c.b, .a = c.a})

#define RECTANGLE(r)                                                           \
  ((Rectangle){.x = r.x, .y = r.y, .width = r.width, .height = r.height})
#define E_RECTANGLE(r)                                                         \
  ((rectangle){.x = r.x, .y = r.y, .width = r.width, .height = r.height})

// XXX: maybe data will not work because is a (void *) and elixir sends a
// payload
#define IMAGE(i)                                                               \
  ((Image){.data = i.data,                                                     \
           .width = i.width,                                                   \
           .height = i.height,                                                 \
           .mipmaps = i.mipmaps,                                               \
           .format = i.format})
#define E_IMAGE(i)                                                             \
  ((image){.data = i.data,                                                     \
           .width = i.width,                                                   \
           .height = i.height,                                                 \
           .mipmaps = i.mipmaps,                                               \
           .format = i.format})

#define TEXTURE(t)                                                             \
  ((Texture){.id = t.id,                                                       \
             .width = t.width,                                                 \
             .height = t.height,                                               \
             .mipmaps = t.mipmaps,                                             \
             .format = t.format})
#define E_TEXTURE(t)                                                           \
  ((texture){.id = t.id,                                                       \
             .width = t.width,                                                 \
             .height = t.height,                                               \
             .mipmaps = t.mipmaps,                                             \
             .format = t.format})

#define TEXTURE_2D(t)                                                          \
  ((Texture2D){.id = t.id,                                                     \
               .width = t.width,                                               \
               .height = t.height,                                             \
               .mipmaps = t.mipmaps,                                           \
               .format = t.format})
#define E_TEXTURE_2D(t)                                                        \
  ((texture_2d){.id = t.id,                                                    \
                .width = t.width,                                              \
                .height = t.height,                                            \
                .mipmaps = t.mipmaps,                                          \
                .format = t.format})

#define CAMERA3D(c)                                                            \
  ((Camera3D){.position = VECTOR3(c.position),                                 \
              .target = VECTOR3(c.target),                                     \
              .up = VECTOR3(c.up),                                             \
              .fovy = c.fovy,                                                  \
              .projection = c.projection})
#define E_CAMERA3D(c)                                                          \
  ((camera_3d){.position = E_VECTOR3(c.position),                              \
               .target = E_VECTOR3(c.target),                                  \
               .up = E_VECTOR3(c.up),                                          \
               .fovy = c.fovy,                                                 \
               .projection = c.projection})

#define CAMERA2D(c)                                                            \
  ((Camera2D){.offset = VECTOR2(c.offset),                                     \
              .target = VECTOR2(c.target),                                     \
              .rotation = c.rotation,                                          \
              .zoom = c.zoom})
#define E_CAMERA2D(c)                                                          \
  ((camera_2d){.offset = E_VECTOR2(c.offset),                                  \
               .target = E_VECTOR2(c.target),                                  \
               .rotation = c.rotation,                                         \
               .zoom = c.zoom})

#define RAY(v)                                                                 \
  ((Ray){.position = VECTOR3(v.position), .direction = VECTOR3(v.direction)})
#define E_RAY(v)                                                               \
  ((ray){.position = E_VECTOR3(v.position),                                    \
         .direction = E_VECTOR3(v.direction)})

#define RAY_COLLISION(v)                                                       \
  ((RayCollision){.hit = v.hit,                                                \
                  .distance = v.distance,                                      \
                  .point = VECTOR3(v.point),                                   \
                  .normal = VECTOR3(v.normal)})
#define E_RAY_COLLISION(v)                                                     \
  ((ray_collision){.hit = v.hit,                                               \
                   .distance = v.distance,                                     \
                   .point = E_VECTOR3(v.point),                                \
                   .normal = E_VECTOR3(v.normal)})

#define BOUNDING_BOX(v)                                                        \
  ((BoundingBox){.min = VECTOR3(v.min), .max = VECTOR3(v.max)})
#define E_BOUNDING_BOX(v)                                                      \
  ((bounding_box){.min = E_VECTOR3(v.min), .max = E_VECTOR3(v.max)})

#endif
