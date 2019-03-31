defmodule UniqGid.IdPoolTest do
  use ExUnit.Case
  use Bitwise
  alias UniqGid.IdPool

  test 'get_id returns value in 0 to 2 ^ 128 -1' do
    {:ok, id} = IdPool.get_id()
    assert id > 0
    assert id < (2 <<< 128) - 1
  end
end
