defmodule UniqGid.SequenceStoreETS do
  use Agent

  @init_value 0
  @counter_key :seq

  @spec init(any()) :: {:ok, %{max_num: any(), table: atom() | :ets.tid()}}
  def init(max_num) do
    table = :ets.new(:state_store, [:public])
    {:ok, %{max_num: max_num, table: table}}
  end

  def next_seq(%{max_num: max_num, table: table}) do
    :ets.update_counter(
      table,
      @counter_key,
      {2, 1, max_num - 1, @init_value},
      {1, @init_value - 1}
    )
  end
end
