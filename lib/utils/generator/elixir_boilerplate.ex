defmodule Utils.Generator.ElixirBoilerplate do
  @moduledoc false
  require Logger

  def include(module, file_path) do
    """
    defmodule Rayex.#{module} do
      @on_load :load_nifs

      def load_nifs do
        :erlang.load_nif('#{file_path}', 0)
      end
    """
  end
end
