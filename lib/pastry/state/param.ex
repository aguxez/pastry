defmodule Pastry.State.Param do
  @moduledoc false

  use Agent

  def start_link(_),
    do: Agent.start_link(fn -> [] end, name: __MODULE__)

  def save(value) do
    Agent.update(__MODULE__, &List.insert_at(&1, -1, value))

    Enum.join(get(), "&")
  end

  def get,
    do: Agent.get(__MODULE__, &(&1))

  def clean,
    do: Agent.update(__MODULE__, fn _ -> [] end)
end
