defmodule Jwfinances.Account do
  @fields [:month, :year, :month_invoicing ,account_balance: 0, payments: [] ]
  @enforce_keys [ :month, :year, :month_invoicing ]
  defstruct @fields

  def create(month,year,month_invoicing) do
    %Jwfinances.Account{ month: month, year: year, month_invoicing: month_invoicing}
  end

  def deposit(value) when value < 0, do: {:error, "Invalid value"}

  def deposit(value) do
    Jwfinances.current_state()
    |> deposit(value)
    |> update_balance()
  end

  defp deposit(account, value) do
    account
    |> Map.get(:account_balance)
    |> sum_balance(value)
  end

  defp sum_balance(actual_value, new_value) do
    actual_value + new_value
  end

  defp update_balance(value) do
    Jwfinances.current_state()
    |> Map.put(:account_balance, value)
    |> Jwfinances.update_state()
  end

end
