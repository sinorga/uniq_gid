defmodule UniqGid.SequenceStore do
  use Agent

  @init_value 0
  @spec init(any()) :: {:ok, %{max_num: integer()}}
  def init(max_num) do
    Agent.start_link(fn -> @init_value end, name: __MODULE__)
    {:ok, %{max_num: max_num}}
  end

  @spec next_seq(%{max_num: integer()}) :: integer()
  def next_seq(%{max_num: max_num}) do
    Agent.get_and_update(__MODULE__, fn state -> {state, Integer.mod(state + 1, max_num)} end)
  end
end
