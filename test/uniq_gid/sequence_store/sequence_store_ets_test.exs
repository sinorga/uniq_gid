defmodule UniqGid.SequenceStoreETSTest do
  use ExUnit.Case
  alias UniqGid.SequenceStoreETS

  @moduletag max_seq: 8
  setup %{max_seq: max_seq} do
    {:ok, store} = SequenceStoreETS.init(max_seq)
    {:ok, store: store, max_seq: max_seq}
  end

  describe "next_seq" do
    test "returns plus one of previous value", %{store: store} do
      prev = SequenceStoreETS.next_seq(store)
      current = SequenceStoreETS.next_seq(store)

      assert current === prev + 1
    end

    test "returns values less than max value", %{store: store, max_seq: max_seq} do
      test_max = max_seq + 10
      Enum.each(1..test_max, fn _ -> assert SequenceStoreETS.next_seq(store) < max_seq end)
    end

    @tag max_seq: 1000
    test "returns correct value after accessed concurrently", %{store: store, max_seq: max_seq} do
      add_count = 800

      ids =
        Enum.map(1..add_count, fn _ ->
          Task.async(fn ->
            SequenceStoreETS.next_seq(store)
          end)
        end)
        |> Enum.map(&Task.await/1)
        |> Enum.uniq()

      assert length(ids) === add_count
      assert SequenceStoreETS.next_seq(store) === add_count
    end
  end
end
