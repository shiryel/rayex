defmodule Rayex.Keys do
  @moduledoc """
    Keys helper functions
  """

  defmacro __using__(_) do
    quote do
      import Rayex.Keys
    end
  end

  def key_null, do: 0
  def key_apostrophe, do: 39
  def key_comma, do: 44
  def key_minus, do: 45
  def key_period, do: 46
  def key_slash, do: 47
  def key_zero, do: 48
  def key_one, do: 49
  def key_two, do: 50
  def key_three, do: 51
  def key_four, do: 52
  def key_five, do: 53
  def key_six, do: 54
  def key_seven, do: 55
  def key_eight, do: 56
  def key_nine, do: 57
  def key_semicolon, do: 59
  def key_equal, do: 61
  def key_a, do: 65
  def key_b, do: 66
  def key_c, do: 67
  def key_d, do: 68
  def key_e, do: 69
  def key_f, do: 70
  def key_g, do: 71
  def key_h, do: 72
  def key_i, do: 73
  def key_j, do: 74
  def key_k, do: 75
  def key_l, do: 76
  def key_m, do: 77
  def key_n, do: 78
  def key_o, do: 79
  def key_p, do: 80
  def key_q, do: 81
  def key_r, do: 82
  def key_s, do: 83
  def key_t, do: 84
  def key_u, do: 85
  def key_v, do: 86
  def key_w, do: 87
  def key_x, do: 88
  def key_y, do: 89
  def key_z, do: 90
  def key_left_bracket, do: 91
  def key_backslash, do: 92
  def key_right_bracket, do: 93
  def key_grave, do: 96
  def key_space, do: 32
  def key_escape, do: 256
  def key_enter, do: 257
  def key_tab, do: 258
  def key_backspace, do: 259
  def key_insert, do: 260
  def key_delete, do: 261
  def key_right, do: 262
  def key_left, do: 263
  def key_down, do: 264
  def key_up, do: 265
  def key_page_up, do: 266
  def key_page_down, do: 267
  def key_home, do: 268
  def key_end, do: 269
  def key_caps_lock, do: 280
  def key_scroll_lock, do: 281
  def key_num_lock, do: 282
  def key_print_screen, do: 283
  def key_pause, do: 284
  def key_f1, do: 290
  def key_f2, do: 291
  def key_f3, do: 292
  def key_f4, do: 293
  def key_f5, do: 294
  def key_f6, do: 295
  def key_f7, do: 296
  def key_f8, do: 297
  def key_f9, do: 298
  def key_f10, do: 299
  def key_f11, do: 300
  def key_f12, do: 301
  def key_left_shift, do: 340
  def key_left_control, do: 341
  def key_left_alt, do: 342
  def key_left_super, do: 343
  def key_right_shift, do: 344
  def key_right_control, do: 345
  def key_right_alt, do: 346
  def key_right_super, do: 347
  def key_kb_menu, do: 348
  def key_kp_0, do: 320
  def key_kp_1, do: 321
  def key_kp_2, do: 322
  def key_kp_3, do: 323
  def key_kp_4, do: 324
  def key_kp_5, do: 325
  def key_kp_6, do: 326
  def key_kp_7, do: 327
  def key_kp_8, do: 328
  def key_kp_9, do: 329
  def key_kp_decimal, do: 330
  def key_kp_divide, do: 331
  def key_kp_multiply, do: 332
  def key_kp_subtract, do: 333
  def key_kp_add, do: 334
  def key_kp_enter, do: 335
  def key_kp_equal, do: 336
  def key_back, do: 4
  def key_menu, do: 82
  def key_volume_up, do: 24
  def key_volume_down, do: 25
end
