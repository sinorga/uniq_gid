defmodule UniqGid do
  @moduledoc """
  Documentation for UniqGid.
  """
  alias UniqGid.IdPool
  defdelegate get_id, to: IdPool
end
