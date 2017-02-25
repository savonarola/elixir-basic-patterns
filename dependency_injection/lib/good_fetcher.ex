defmodule GoodFetcher do
  use GenServer

  defstruct [:http]

  def start_link(args \\ []) do
    opts = Keyword.get(args, :opts, [])
    GenServer.start_link(__MODULE__, args, opts)
  end

  def init(args) do
    http = Keyword.get(args, :http, HTTPoison)
    {:ok, %GoodFetcher{http: http}}
  end

  def fetch(pid, url) do
    GenServer.call(pid, {:fetch, url})
  end

  def handle_call({:fetch, url}, _from, state) do
    result = state.http.get!(url).body
    {:reply, result, state}
  end

end
