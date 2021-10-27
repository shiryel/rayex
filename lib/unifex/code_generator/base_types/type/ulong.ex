defmodule Unifex.CodeGenerator.BaseTypes.Ulong do
  @moduledoc """
  Module implementing `Unifex.CodeGenerator.BaseType` behaviour for floats.
  Implemented both for NIF and CNode as function parameter as well as return type.
  """
  alias Unifex.CodeGenerator.BaseType
  use BaseType

  @impl BaseType
  def generate_native_type(_ctx) do
    ~g<unsigned long>
  end
end
