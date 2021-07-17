defmodule Utils.Generator.CBoilerplateTest do
  use ExUnit.Case

  alias Utils.Generator.CBoilerplate

  test "get_function/1" do
    input = """
      bool IsWindowFullscreen(void);                                          // Check if window is currently fullscreen
    """

    assert {"is_window_fullscreen", 0} == CBoilerplate.get_function(input)
  end

  test "nif_stuff/2" do
    result = """
    /************
    * NIF INIT *
    ************/

    static ErlNifFunc nif_funcs[] = {
      // {erl_function_name, erl_function_arity, c_function}
      {"test", 2, test},
      {"lol", 0, lol}
    };

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
    ERL_NIF_INIT(Elixir.Rayex.Test, nif_funcs, load, reload, upgrade, unload)
    """

    assert result == CBoilerplate.nif_stuff([{"test", 2}, {"lol", 0}], "Elixir.Rayex.Test")
  end
end
