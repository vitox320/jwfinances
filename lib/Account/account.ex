defmodule Jwfinances.Account do
  alias Jwfinances.State

  @fields [:month, :year, :month_invoicing ,account_balance: 0, payments: [] ]
  @enforce_keys [ :month, :year, :month_invoicing ]
  defstruct @fields

  def create(month,year,month_invoicing) do
    %Jwfinances.Account{ month: month, year: year, month_invoicing: month_invoicing}
  end

  def new_account(month, year, month_invoicing) do
    State.current_state()
    |> Map.get(:accounts)
    |> validate_account(year, month)
    |> fill_accounts(create(month, year, month_invoicing))
    |> add_account_state()
  end

  defp validate_account(accounts, year, month) do
    accounts
    |> validate_month_year(year, month)
  end

  defp validate_month_year(accounts, _, _) when is_list(accounts) and length(accounts) == 0,
    do: {:ok, accounts}

  defp validate_month_year(balance_accounts, year, month) do
    if balance_accounts |> Enum.any?(fn x -> x.year == year && x.month == month end) do
      {:error, "This balance account already exists"}
    else
      {:ok, balance_accounts}
    end
  end

  defp fill_accounts({:error, message}, _) do
    {:error, message}
  end

  defp fill_accounts({:ok, accounts}, account) do
    {:ok, [account | accounts]}
  end

  defp add_account_state({:error, message}) do
    message
  end

  defp add_account_state({:ok, accounts}) do
    State.current_state()
    |> Map.put(:accounts, accounts)
    |> State.update_state()
  end


end
