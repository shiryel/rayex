defmodule Unifex.CodeGenerator.BaseTypes.Ulong do
  @moduledoc false

  alias Unifex.CodeGenerator.BaseType
  use BaseType

  @impl BaseType
  def generate_native_type(_ctx) do
    ~g<unsigned long>
  end
end
