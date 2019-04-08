defmodule UniqGid.IdPool do
  @moduledoc """
    Unique id pool.
  """

  use Bitwise
  alias UniqGid.SequenceStoreETS

  defstruct seq_store: %SequenceStoreETS{}, node_id: 1

  @timestamp_size 48
  @node_id_size 64
  @max_node_id (1 <<< 64) - 1
  @local_sequence_size 16

  @spec init(non_neg_integer()) ::
          {:error, :invalid_node_id}
          | {:ok, UniqGid.IdPool.t()}
  def init(node_id) when node_id < 0 or node_id > @max_node_id, do: {:error, :invalid_node_id}

  def init(node_id) do
    {:ok, store} = SequenceStoreETS.init(1 <<< @local_sequence_size)
    {:ok, %{seq_store: store, node_id: node_id}}
  end

  @spec get_id(SequenceStoreETS.t()) :: {:ok, non_neg_integer()}
  def get_id(%{seq_store: store, node_id: node_id}) do
    <<id::size(128)>> =
      <<get_timestamp()::size(@timestamp_size), node_id::size(@node_id_size),
        get_sequence_num(store)::size(@local_sequence_size)>>

    {:ok, id}
  end

  defp get_timestamp do
    :os.system_time(:millisecond)
  end

  defp get_sequence_num(store) do
    SequenceStoreETS.next_seq(store)
  end
end
