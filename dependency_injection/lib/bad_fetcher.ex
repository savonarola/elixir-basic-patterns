defmodule BadFetcher do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init([]) do
    {:ok, []}
  end

  def fetch(pid, url) do
    GenServer.call(pid, {:fetch, url})
  end

  def handle_call({:fetch, url}, _from, state) do
    result = HTTPoison.get!(url).body
    {:reply, result, state}
  end

end
