defmodule Utils.Generator.CFunctionTest do
  use ExUnit.Case

  alias Utils.Generator.CFunction

  test "r(void) p(int, const char *)" do
    input =
      "void InitWindow(int width, int height, const char *title);              // Initialize window and OpenGL context"

    return = """
    static ERL_NIF_TERM init_window(ErlNifEnv *env, int argc,
                                    const ERL_NIF_TERM argv[]) {
      // var: width
      int width;
      if (enif_get_int(env, argv[0], &width) < 1)
        return enif_make_badarg(env);
    
      // var: height
      int height;
      if (enif_get_int(env, argv[1], &height) < 1)
        return enif_make_badarg(env);
    
      // var: title
      unsigned int title_len;
      enif_get_list_length(env, argv[2], &title_len);
    
      unsigned title_size = sizeof(char *) * (title_len + 1);
      char *title = enif_alloc(title_size);

      /*
      if (!title) {
        // TODO
        // treat enif_alloc fail
      }
      */

      if (enif_get_string(env, argv[2], title, title_size, ERL_NIF_LATIN1) < 1)
        return enif_make_badarg(env);
    
      // binding
      InitWindow(width, height, title);
    
      // free memory
      enif_free(title);
    
      return enif_make_atom(env, "ok");
    }
    """

    assert return == CFunction.parser(input)
  end
end
