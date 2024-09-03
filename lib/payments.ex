defmodule Jwfinances.Payments do
  @fields [:name, :value]
  @enforce_keys @fields
  defstruct @fields

  def create(name, value) do
    %Jwfinances.Payments{name: name, value: value}
  end


end
