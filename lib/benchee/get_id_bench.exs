{:ok, pool} = UniqGid.init()

Benchee.run(
  %{
    "ets store" => fn -> UniqGid.get_id(pool) end
  },
  time: 10
)
