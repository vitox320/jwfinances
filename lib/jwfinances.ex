defmodule Jwfinances do
  use Agent
  alias Jwfinances.{Account,State}

  def setup(user) do
    %{user: user, accounts: []}
    |> State.set_state()
  end

  def new_account(month, year, month_invoicing) do
    Account.new_account(month, year, month_invoicing)
  end
end
