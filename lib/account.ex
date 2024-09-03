defmodule Jwfinances.Account do
  @fields [:user, :account_balance]
  @enforce_keys [:account_balance, :user]
  defstruct @fields

  def create(user) do
    %Jwfinances.Account{user: user, account_balance: 0}
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
