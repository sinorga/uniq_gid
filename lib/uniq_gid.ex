defmodule UniqGid do
  @moduledoc """
  Documentation for UniqGid.
  """
  alias UniqGid.IdPool
  defdelegate init, to: IdPool
  defdelegate get_id(pool), to: IdPool
end
