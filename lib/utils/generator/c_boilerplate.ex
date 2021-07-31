defmodule Utils.Generator.CBoilerplate do
  @moduledoc false
  require Logger

  def include do
    """
    #include "erl_nif.h"
    #include "raylib.h"
    """
  end

  @doc """
    Used to get all functions on the entire text
  """
  def get_function(line) do
    regex = ~r/(?<return>.*) (?<function>[[:alnum:]]+)\((?<params>.*)\).*\/\//

    case Regex.named_captures(regex, line) do
      %{
        "function" => function,
        "params" => params
      } ->
        arity =
          String.split(params, ",")
          |> Enum.reject(fn x -> x == "void" end)
          |> length()

        function_ = Macro.underscore(function)

        {function_, arity}
    end
  end

  @spec nif_stuff([{String.t(), integer()}], String.t()) :: String.t()
  def nif_stuff(functions, elixir_module) do
    """
    /************
     * NIF INIT *
     ************/

    static ErlNifFunc nif_funcs[] = {
      // {erl_function_name, erl_function_arity, c_function}
    #{nif_funcs(functions)}
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
    ERL_NIF_INIT(#{elixir_module}, nif_funcs, load, reload, upgrade, unload)
    """
  end

  defp nif_funcs(functions) do
    Enum.map(functions, fn
      {name, arity} -> ~s|  {"#{name}", #{arity}, #{name}}|
    end)
    |> Enum.join(",\n")
  end
end
