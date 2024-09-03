defmodule Jwfinances do
  use Agent
  alias Jwfinances.Account

  def setup(user) do
    %{user: user, accounts: []}
    |> set_state()
  end

  def new_account(month, year, month_invoicing) do
    current_state()
    |> Map.get(:accounts)
    |> fill_accounts(Account.create(month, year, month_invoicing))
    |> add_account_state()
  end

  defp fill_accounts(accounts, account) do
    [account | accounts]
  end

  defp add_account_state(accounts) do
    current_state()
    |> Map.put(:accounts, accounts)
    |> update_state()
  end

  def set_state(state) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def current_state do
    Agent.get(__MODULE__, & &1)
  end

  def update_state(state) do
    Agent.update(__MODULE__, fn _ -> state end)
  end
end
