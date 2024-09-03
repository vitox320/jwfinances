defmodule Jwfinances.User do
  @fields [:name, :email]

  @enforce_keys @fields
  defstruct @fields

  def create(name, email) do
    %Jwfinances.User{name: name, email: email}
  end
end
