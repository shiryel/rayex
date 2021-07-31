#include "erl_nif.h"
#include "raylib.h"

// Wrapper type for all Erlang types
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
  unsigned int len;
  enif_get_list_length(env, argv[2], &len);

  unsigned title_size = sizeof(char *) * (len + 1);
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

  // free title
  enif_free(title);

  return enif_make_atom(env, "ok");
}

/************
 * NIF INIT *
 ************/

static ErlNifFunc nif_funcs[] = {
    // {erl_function_name, erl_function_arity, c_function}
    {"init_window", 3, init_window}};

static int load(ErlNifEnv *env, void **priv_data, ERL_NIF_TERM load_info) {
  return 0;
}

static int upgrade(ErlNifEnv *env, void **priv_data, void **old_priv_data,
                   ERL_NIF_TERM load_info) {
  return 0;
}

static int reload(ErlNifEnv *env, void **priv_data, ERL_NIF_TERM load_info) {
  return 0;
}

static void unload(ErlNifEnv *env, void *priv_data) {}

// needs to be the same module on elixir
ERL_NIF_INIT(Elixir.Rayex.Core, nif_funcs, load, reload, upgrade, unload)
