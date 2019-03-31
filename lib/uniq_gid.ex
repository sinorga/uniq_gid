defmodule UniqGid do
  @moduledoc """
  Documentation for UniqGid.
  """
  alias UniqGid.IdPool
  defdelegate init(node_id), to: IdPool
  defdelegate get_id(pool), to: IdPool
end
