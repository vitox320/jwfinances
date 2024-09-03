defmodule Jwfinances do
  use Agent
  alias Jwfinances.Account

  def setup(user) do
    user
    |> Account.create()
    |> set_state()
  end

  def set_state(user_account) do
    Agent.start_link(fn -> user_account end, name: __MODULE__)
  end

  def current_state do
    Agent.get(__MODULE__, & &1)
  end

  def update_state(user_account) do
    Agent.update(__MODULE__, fn _ -> user_account end)
  end
end
