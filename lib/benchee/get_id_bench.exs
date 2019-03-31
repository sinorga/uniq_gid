{:ok, pool} = UniqGid.init()

Benchee.run(
  %{
    "agent store" => fn -> UniqGid.get_id(pool) end
  },
  time: 10
)
