# UniqGid

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `uniq_gid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:uniq_gid, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/uniq_gid](https://hexdocs.pm/uniq_gid).

## Benchmark

**Agent**
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.8.1
Erlang 21.1.4

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 10 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 12 s

Benchmarking agent store...

Name ips average deviation median 99th %
agent store 350.32 K 2.85 μs ±1512.06% 3 μs 6 μs
