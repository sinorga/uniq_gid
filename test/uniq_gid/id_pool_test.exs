defmodule UniqGid.IdPoolTest do
  use ExUnit.Case
  use Bitwise
  alias UniqGid.IdPool

  setup %{} do
    {:ok, pool} = IdPool.init()
    {:ok, pool: pool}
  end

  test 'get_id returns value in 0 to 2 ^ 128 -1', %{pool: pool} do
    {:ok, id} = IdPool.get_id(pool)
    assert id > 0
    assert id < (2 <<< 128) - 1
  end

  test 'get_id returns different values', %{pool: pool} do
    ids =
      Enum.map(1..1_000_000, fn _ -> IdPool.get_id(pool) end)
      |> Enum.map(fn {:ok, id} -> id end)
      |> Enum.uniq()

    assert length(ids) === 1_000_000
  end
end
