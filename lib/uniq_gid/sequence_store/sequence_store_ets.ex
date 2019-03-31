defmodule UniqGid.SequenceStoreETS do
  use Agent

  defstruct max_num: %{}, table: nil

  @init_value 0
  @counter_key :seq

  @spec init(any()) :: {:ok, UniqGid.SequenceStoreETS.t()}
  def init(max_num) do
    table = :ets.new(:state_store, [:public])
    {:ok, %__MODULE__{max_num: max_num, table: table}}
  end

  @spec next_seq(UniqGid.SequenceStoreETS.t()) :: integer()
  def next_seq(%{max_num: max_num, table: table}) do
    :ets.update_counter(
      table,
      @counter_key,
      {2, 1, max_num - 1, @init_value},
      {1, @init_value - 1}
    )
  end
end
