defmodule UniqGid.SequenceStoreTest do
  use ExUnit.Case
  alias UniqGid.SequenceStore

  setup %{} do
    max_seq = 8
    {:ok, store} = SequenceStore.init(max_seq)
    {:ok, store: store, max_seq: max_seq}
  end

  test "next_seq returns plus one of previous value", %{store: store} do
    prev = SequenceStore.next_seq(store)
    current = SequenceStore.next_seq(store)

    assert current === prev + 1
  end

  test "next_seq returns values less than max value", %{store: store, max_seq: max_seq} do
    test_max = max_seq + 10
    Enum.each(1..test_max, fn _ -> assert SequenceStore.next_seq(store) < max_seq end)
  end
end
