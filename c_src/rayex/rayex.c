#include "rayex.h"
#include <raylib.h>

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
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  ClearBackground(color);
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
  vector2 res = {.x = r.x, .y = r.y};
  return get_mouse_position_result(env, res);
}

// Input-related functions: touch

// Gestures and Touch Handling Functions (Module: rgestures)

// Camera System Functions (Module: rcamera)

/**********
 * SHAPES *
 **********/

// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call

UNIFEX_TERM set_shapes_texture(UnifexEnv* env, texture_2d t, rectangle s) {
  Texture2D texture = {.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format};
  Rectangle source = {.x = s.x, .y = s.y, .width = s.width, .height = s.height};
  SetShapesTexture(texture, source);
  return set_shapes_texture_result_ok(env);
}

// Basic shapes drawing functions

UNIFEX_TERM draw_pixel(UnifexEnv* env, int x, int y, color c) {
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawPixel(x, y, color);
  return draw_pixel_result_ok(env);
}

UNIFEX_TERM draw_line(UnifexEnv* env, int start_x, int start_y, int end_x, int end_y, color c) {
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawLine(start_x, start_y, end_x, end_y, color);
  return draw_pixel_result_ok(env);
}

UNIFEX_TERM draw_rectangle_rec(UnifexEnv* env, rectangle r, color c) {
  Rectangle rec = {.x = r.x, .y = r.y, .width = r.width, .height = r.height};
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawRectangleRec(rec, color);
  return draw_rectangle_rec_result_ok(env);
}

UNIFEX_TERM draw_rectangle_lines_ex(UnifexEnv* env, rectangle r, int line_thick, color c) {
  Rectangle rec = {.x = r.x, .y = r.y, .width = r.width, .height = r.height};
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawRectangleLinesEx(rec, line_thick, color);
  return draw_rectangle_lines_ex_result_ok(env);
}

UNIFEX_TERM draw_triangle(UnifexEnv* env, vector2 v1, vector2 v2, vector2 v3, color c) {
  Vector2 v1_ = {.x = v1.x, .y = v1.y};
  Vector2 v2_ = {.x = v2.x, .y = v2.y};
  Vector2 v3_ = {.x = v3.x, .y = v3.y};
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawTriangle(v1_, v2_, v3_, color);
  return draw_triangle_result_ok(env);
}

// Basic shapes collision detection functions

UNIFEX_TERM check_collision_point_rec(UnifexEnv* env, vector2 p, rectangle r) {
  Vector2 point = {.x = p.x, .y = p.y};
  Rectangle rec = {.x = r.x, .y = r.y, .width = r.width, .height = r.height};
  bool res = CheckCollisionPointRec(point, rec);
  return check_collision_point_rec_result(env, res);
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
  Color color = {.r = c.r, .g = c.g, .b = c.b, .a = c.a};
  DrawText(text, posX, posY, fontSize, color);
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
