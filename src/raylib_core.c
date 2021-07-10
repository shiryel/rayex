#include "raylib.h"
#include "erl_nif.h"

// Wrapper type for all Erlang types
static ERL_NIF_TERM init_window(ErlNifEnv *env, int argc,
                                const ERL_NIF_TERM argv[]) {
  int width, height;
  // FIXME: add check of size
  char title[1024];

  enif_get_int(env, argv[0], &width);
  enif_get_int(env, argv[1], &height);
  enif_get_string(env, argv[2], title, sizeof(title), ERL_NIF_LATIN1);

  InitWindow(width, height, title);
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
