defmodule UniqGid.IdPool do
  @moduledoc """
  ID format:
  48 bits: millisecond timestamp, support over 1000 years
  64 bits: node id
  16 bits: local sequence
  """

  use Bitwise
  alias UniqGid.SequenceStore

  @timestamp_size 48
  @node_id_size 64
  @local_sequence_size 16

  @spec init() :: {:ok, %{seq_store: %{max_num: integer()}}}
  def init() do
    {:ok, store} = SequenceStore.init(1 <<< @local_sequence_size)
    {:ok, %{seq_store: store}}
  end

  @doc """
  To get globally unique numeric ids.
  These ids should be greater than or equal to 0 and less than or equal to (2 ^ 128) - 1.
  Since these ids are globally unique, each id can only be given out at most once.
  Your service needs to run worldwide and tolerate failures of individual hosts
  along with whole regions.
  """
  def get_id(%{seq_store: store}) do
    <<id::size(128)>> =
      <<get_timestamp()::size(@timestamp_size), get_node_id()::size(@node_id_size),
        get_sequence_num(store)::size(@local_sequence_size)>>

    {:ok, id}
  end

  defp get_timestamp do
    :os.system_time(:millisecond)
  end

  defp get_sequence_num(store) do
    SequenceStore.next_seq(store)
  end

  defp get_node_id do
    1
  end
end
