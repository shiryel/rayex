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

// Drawing-related functions

UNIFEX_TERM begin_drawing(UnifexEnv* env) {
  BeginDrawing();
  return begin_drawing_result_ok(env);
}

UNIFEX_TERM end_drawing(UnifexEnv* env) {
  EndDrawing();
  return end_drawing_result_ok(env);
}

/**********
 * SHAPES *
 **********/

UNIFEX_TERM set_shapes_texture(UnifexEnv* env, texture_2d t, rectangle s) {
  Texture2D texture = {.id = t.id, .width = t.width, .height = t.height, .mipmaps = t.mipmaps, .format = t.format};
  Rectangle source = {.x = s.x, .y = s.y, .width = s.width, .height = s.height};
  SetShapesTexture(texture, source);
  return set_shapes_texture_result_ok(env);
}

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

/************
 * TEXTURES *
 ************/

/********
 * TEXT *
 ********/

/**********
 * MODELS *
 **********/

/*********
 * AUDIO *
 *********/

/***********
 * STRUCTS *
 ***********/
