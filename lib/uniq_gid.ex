defmodule UniqGid do
  @moduledoc """
  UniqGid, a global unique numeric id generator.

  ID format:
  48 bits: millisecond timestamp, supports over 1000 years
  64 bits: node id
  16 bits: local sequence, supports up to 65M request/s per node.
  """
  alias UniqGid.IdPool

  @doc """
  Initialize module with `node_id` from 0 to (2 ^ 64) - 1.
  Make sure the given `node_id` is unique across your nodes in elixir cluster.
  """
  defdelegate init(node_id), to: IdPool

  @doc """
  To get globally unique numeric id which is greater than or equal to 0 and
  less than or equal to (2 ^ 128) - 1.
  """
  defdelegate get_id(pool), to: IdPool
end
