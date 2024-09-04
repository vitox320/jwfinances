defmodule Jwfinances.State do
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
