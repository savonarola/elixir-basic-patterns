defmodule Patterns do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(GoodFetcher, [[opts: [name: GoodFetcher]]])
    ]


    poolboy_config = [
      name: {:local, GoodFetcherPool},
      worker_module: GoodFetcher,
      size: 30,
      max_overflow: 1
    ]

    poolboy_children = [
      :poolboy.child_spec(GoodFetcherPool, poolboy_config, [])
    ]
    # :poolboy.transaction(GoodFetcherPool, fn(pid) -> GoodFetcher.fetch(pid, "https://ya.ru") end)

    opts = [strategy: :one_for_one, name: Patterns.Supervisor]
    Supervisor.start_link(children ++ poolboy_children, opts)
  end

end
