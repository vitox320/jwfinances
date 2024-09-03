defmodule Jwfinances.Payments do
  @fields [:name, :value, :date]
  @enforce_keys @fields
  defstruct @fields

  def create(name, value, date) do
    %Jwfinances.Payments{name: name, value: value, date: setDate(date)}
  end

  defp setDate(date) do
    Date.from_iso8601(date)
    |> validate_date()
  end

  defp validate_date({:ok, date}) do
    {:ok, date |> Date.to_string()}
  end

  defp validate_date({:error, _}) do
    {:error, "invalid date"}
  end
end
