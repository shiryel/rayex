#include "rayex.h"
#include <raylib.h>

// NOTE: "E_" when converting back to NIF struct

#define VECTOR2(v) ((Vector2){.x = v.x, .y = v.y})
#define E_VECTOR2(v) ((vector2){.x = v.x, .y = v.y})

#define VECTOR3(v) ((Vector3){.x = v.x, .y = v.y, .z = v.z})
#define E_VECTOR3(v) ((vector3){.x = v.x, .y = v.y, .z = v.z})

#define VECTOR4(v) ((Vector4){.x = v.x, .y = v.y, .z = v.z, .w = v.w})
#define E_VECTOR4(v) ((vector4){.x = v.x, .y = v.y, .z = v.z, .w = v.w})

#define QUATERNION(q) ((Quaternion){.x = q.x, .y = q.y, .z = q.z, .w = q.w})
#define E_QUATERNION(q) ((quaternion){.x = q.x, .y = q.y, .z = q.z, .w = q.w})

#define MATRIX(m) ((Matrix){.m0 = m.m0, .m1 = m.m1, .m2 = m.m2, .m3 = m.m3, .m4 = m.m4, .m5 = m.m5, .m6 = m.m6, .m7 = m.m7, .m8 = m.m8, .m9 = m.m9, .m10 = m.m10, .m11 = m.m11, .m12 = m.m12, .m13 = m.m13, .m14 = m.m14, .m15 = m.m15})
#define E_MATRIX(m) ((matrix){.m0 = m.m0, .m1 = m.m1, .m2 = m.m2, .m3 = m.m3, .m4 = m.m4, .m5 = m.m5, .m6 = m.m6, .m7 = m.m7, .m8 = m.m8, .m9 = m.m9, .m10 = m.m10, .m11 = m.m11, .m12 = m.m12, .m13 = m.m13, .m14 = m.m14, .m15 = m.m15})

#define COLOR(c) ((Color){.r = c.r, .g = c.g, .b = c.b, .a = c.a})
#define E_COLOR(c) ((color){.r = c.r, .g = c.g, .b = c.b, .a = c.a})

#define RECTANGLE(r) ((Rectangle){.x = r.x, .y = r.y, .width = r.width, .height = r.height})
#define E_RECTANGLE(r) ((rectangle){.x = r.x, .y = r.y, .width = r.width, .height = r.height})

// XXX: maybe data will not work because is a (void *) and elixir sends a payload
#define IMAGE(i) ((Image){.data = i.data, .width = i.width, .height = i.height, .mipmaps = i.mipmaps, .format = i.format})
#define E_IMAGE(i) ((image){.data = i.data, .width = i.width, .height = i.height, .mipmaps = i.mipmaps, .format = i.format})

#define TEXTURE(t) ((Texture){.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format})
#define E_TEXTURE(t) ((texture){.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format})

#define TEXTURE_2D(t) ((Texture2D){.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format})
#define E_TEXTURE_2D(t) ((texture_2d){.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format})

#define CAMERA3D(c) ((Camera3D){.position = VECTOR3(c.position), .target = VECTOR3(c.target), .up = VECTOR3(c.up), .fovy = c.fovy, .projection = c.projection})
#define E_CAMERA3D(c) ((camera_3d){.position = VECTOR3(c.position), .target = VECTOR3(c.target), .up = VECTOR3(c.up), .fovy = c.fovy, .projection = c.projection})

#define RAY(v) ((Ray){.position = VECTOR3(v.position), .direction = VECTOR3(v.direction)})
#define E_RAY(v) ((ray){.position = E_VECTOR3(v.position), .direction = E_VECTOR3(v.direction)})

#define RAY_COLLISION(v) ((RayCollision){.hit = v.hit, .distance = v.distance, .point = VECTOR3(v.point), .normal = VECTOR3(v.normal)})
#define E_RAY_COLLISION(v) ((ray_collision){.hit = v.hit, .distance = v.distance, .point = E_VECTOR3(v.point), .normal = E_VECTOR3(v.normal)})

#define BOUNDING_BOX(v) ((BoundingBox){.min = VECTOR3(v.min), .max = VECTOR3(v.max)})
#define E_BOUNDING_BOX(v) ((bounding_box){.min = E_VECTOR3(v.min), .max = E_VECTOR3(v.max)})

/********
 * CORE *
 ********/

// Window-related functions

UNIFEX_TERM init_window(UnifexEnv* env, int width, int height, char *title) {
  InitWindow(width, height, title);
  return init_window_result_ok(env);
}

UNIFEX_TERM window_should_close(UnifexEnv* env) {
  bool res = WindowShouldClose();
  return window_should_close_result(env, res);
}

UNIFEX_TERM close_window(UnifexEnv* env) {
  CloseWindow();
  return close_window_result_ok(env);
}

UNIFEX_TERM is_window_ready(UnifexEnv* env) {
  bool res = IsWindowReady();
  return is_window_ready_result(env, res);
}

UNIFEX_TERM is_window_fullscreen(UnifexEnv* env) {
  bool res = IsWindowFullscreen();
  return is_window_fullscreen_result(env, res);
}

UNIFEX_TERM is_window_hidden(UnifexEnv* env) {
  bool res = IsWindowHidden();
  return is_window_hidden_result(env, res);
}

UNIFEX_TERM is_window_minimized(UnifexEnv* env) {
  bool res = IsWindowMinimized();
  return is_window_minimized_result(env, res);
}

UNIFEX_TERM is_window_maximized(UnifexEnv* env) {
  bool res = IsWindowMaximized();
  return is_window_maximized_result(env, res);
}

UNIFEX_TERM is_window_focused(UnifexEnv* env) {
  bool res = IsWindowFocused();
  return is_window_focused_result(env, res);
}

UNIFEX_TERM is_window_resized(UnifexEnv* env) {
  bool res = IsWindowResized();
  return is_window_resized_result(env, res);
}

UNIFEX_TERM is_window_state(UnifexEnv* env, int flag) {
  bool res = IsWindowState(flag);
  return is_window_state_result(env, res);
}

UNIFEX_TERM set_window_state(UnifexEnv* env, int flags) {
  SetWindowState(flags);
  return set_window_state_result_ok(env);
}

UNIFEX_TERM clear_window_state(UnifexEnv* env, int flags) {
  ClearWindowState(flags);
  return clear_window_state_result_ok(env);
}

UNIFEX_TERM toggle_fullscreen(UnifexEnv* env) {
  ToggleFullscreen();
  return toggle_fullscreen_result_ok(env);
}

// Cursor-related functions

// Drawing-related functions

UNIFEX_TERM clear_background(UnifexEnv* env, color c) {
  ClearBackground(COLOR(c));
  return clear_background_result_ok(env);
}

UNIFEX_TERM begin_drawing(UnifexEnv* env) {
  BeginDrawing();
  return begin_drawing_result_ok(env);
}

UNIFEX_TERM end_drawing(UnifexEnv* env) {
  EndDrawing();
  return end_drawing_result_ok(env);
}

// VR stereo config functions for VR simulator

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1

// Screen-space-related functions
UNIFEX_TERM get_mouse_ray(UnifexEnv* env, vector2 mouse_position, camera_3d camera) {
  Ray r = GetMouseRay(VECTOR2(mouse_position), CAMERA3D(camera));
  return get_mouse_ray_result(env, E_RAY(r));
}

// Timing-related functions

UNIFEX_TERM set_target_fps(UnifexEnv* env, int fps) {
  SetTargetFPS(fps);
  return set_target_fps_result_ok(env);
}

UNIFEX_TERM get_fps(UnifexEnv* env) {
  int res = GetFPS();
  return get_fps_result(env, res);
}

UNIFEX_TERM get_frame_time(UnifexEnv* env) {
  float res = GetFrameTime();
  return get_frame_time_result(env, res);
}

UNIFEX_TERM get_time(UnifexEnv* env) {
  double res = GetTime();
  return get_time_result(env, res);
}

// Misc. functions

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users

// Files management functions

// Compression/Encoding functionality

// Persistent storage management

// Misc.

// Input-related functions: keyboard

// Input-related functions: gamepads

// Input-related functions: mouse

UNIFEX_TERM is_mouse_button_pressed(UnifexEnv* env, int button) {
  bool res = IsMouseButtonPressed(button);
  return is_mouse_button_pressed_result(env, res);
}

UNIFEX_TERM is_mouse_button_down(UnifexEnv* env, int button) {
  bool res = IsMouseButtonDown(button);
  return is_mouse_button_down_result(env, res);
}

UNIFEX_TERM is_mouse_button_released(UnifexEnv* env, int button) {
  bool res = IsMouseButtonReleased(button);
  return is_mouse_button_released_result(env, res);
}

UNIFEX_TERM is_mouse_button_up(UnifexEnv* env, int button) {
  bool res = IsMouseButtonUp(button);
  return is_mouse_button_up_result(env, res);
}

UNIFEX_TERM get_mouse_position(UnifexEnv* env) {
  Vector2 r = GetMousePosition();
  return get_mouse_position_result(env, E_VECTOR2(r));
}

// Input-related functions: touch

// Gestures and Touch Handling Functions (Module: rgestures)

// Camera System Functions (Module: rcamera)
UNIFEX_TERM set_camera_mode(UnifexEnv* env, camera_3d c, int mode) {
  SetCameraMode(CAMERA3D(c), mode);
  uintptr_t res = (uintptr_t)&c;
  return set_camera_mode_result(env, res);
}

UNIFEX_TERM update_camera(UnifexEnv* env, uintptr_t camera_id, camera_3d c) {
  Camera3D *camera_ptr = (Camera3D*)camera_id;
  camera_ptr->position = VECTOR3(c.position);
  camera_ptr->target = VECTOR3(c.target);
  camera_ptr->up = VECTOR3(c.up);
  camera_ptr->fovy = c.fovy;
  camera_ptr->projection = c.projection;
  UpdateCamera(camera_ptr);
  return update_camera_result_ok(env);
}

UNIFEX_TERM set_camera_pan_control(UnifexEnv* env, int key_pan) {
  SetCameraPanControl(key_pan);
  return set_camera_pan_control_result_ok(env);
}

UNIFEX_TERM set_camera_alt_control(UnifexEnv* env, int key_alt) {
  SetCameraAltControl(key_alt);
  return set_camera_alt_control_result_ok(env);
}

UNIFEX_TERM set_camera_smooth_zoom_control(UnifexEnv* env, int key_smooth_zoom) {
  SetCameraSmoothZoomControl(key_smooth_zoom);
  return set_camera_smooth_zoom_control_result_ok(env);
}

UNIFEX_TERM set_camera_move_controls(UnifexEnv* env, int key_front, int key_back, int key_right, int key_left, int key_up, int key_down) {
  SetCameraMoveControls(key_front, key_back, key_right, key_left, key_up, key_down);
  return set_camera_move_controls_result_ok(env);
}

/**********
 * SHAPES *
 **********/

// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call

UNIFEX_TERM set_shapes_texture(UnifexEnv* env, texture_2d t, rectangle s) {
  SetShapesTexture(TEXTURE_2D(t), RECTANGLE(s));
  return set_shapes_texture_result_ok(env);
}

// Basic shapes drawing functions

UNIFEX_TERM draw_pixel(UnifexEnv* env, int x, int y, color c) {
  DrawPixel(x, y, COLOR(c));
  return draw_pixel_result_ok(env);
}

UNIFEX_TERM draw_line(UnifexEnv* env, int start_x, int start_y, int end_x, int end_y, color c) {
  DrawLine(start_x, start_y, end_x, end_y, COLOR(c));
  return draw_pixel_result_ok(env);
}

UNIFEX_TERM draw_rectangle_rec(UnifexEnv* env, rectangle r, color c) {
  DrawRectangleRec(RECTANGLE(r), COLOR(c));
  return draw_rectangle_rec_result_ok(env);
}

UNIFEX_TERM draw_rectangle_lines_ex(UnifexEnv* env, rectangle r, int line_thick, color c) {
  DrawRectangleLinesEx(RECTANGLE(r), line_thick, COLOR(c));
  return draw_rectangle_lines_ex_result_ok(env);
}

UNIFEX_TERM draw_triangle(UnifexEnv* env, vector2 v1, vector2 v2, vector2 v3, color c) {
  DrawTriangle(VECTOR2(v1), VECTOR2(v2), VECTOR2(v3), COLOR(c));
  return draw_triangle_result_ok(env);
}

// Basic shapes collision detection functions

UNIFEX_TERM check_collision_point_rec(UnifexEnv* env, vector2 p, rectangle r) {
  bool res = CheckCollisionPointRec(VECTOR2(p), RECTANGLE(r));
  return check_collision_point_rec_result(env, res);
}

UNIFEX_TERM get_ray_collision_box(UnifexEnv* env, ray r, bounding_box b) {
  RayCollision result = GetRayCollisionBox(RAY(r), BOUNDING_BOX(b));
  ray_collision res = E_RAY_COLLISION(result);
  return get_ray_collision_box_result(env, res);
}

/************
 * TEXTURES *
 ************/

// Image loading functions
// NOTE: This functions do not require GPU access

// Image generation functions

// Image manipulation functions

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)

// Texture loading functions
// NOTE: These functions require GPU access

// Texture configuration functions

// Texture drawing functionsc

// Color/pixel related functions

/********
 * TEXT *
 ********/

// Font loading/unloading functions

// Text drawing functions

UNIFEX_TERM draw_text(UnifexEnv* env, char *text, int posX, int posY, int fontSize, color c) {
  DrawText(text, posX, posY, fontSize, COLOR(c));
  return draw_text_result_ok(env);
}

// Text misc. functions

// Text codepoints management functions (unicode characters)

// Text strings management functions (no utf8 strings, only byte chars)         
// NOTE: Some strings allocate memory internally for returned strings, just be careful!

/**********
 * MODELS *
 **********/

// Basic geometric 3D shapes drawing functions

// Model loading/unloading functions

// Model drawing functions

// Mesh management functions

// Mesh generation functions

// Material loading/unloading functions

// Model animations loading/unloading functions

// Collision detection functions

/*********
 * AUDIO *
 *********/

// Audio device management functions

// Wave/Sound loading/unloading functions

// Wave/Sound management functions

// Music management functions

// AudioStream management functions

/***********
 * STRUCTS *
 ***********/
