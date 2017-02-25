defmodule GoodFetcherTest do
  use ExUnit.Case
  alias :doppler, as: Doppler

  defmodule HttpClient do
    def get!(url) do
      %{body: "url: #{url}"}
    end
  end

  test "fetch, manual http client double" do
    {:ok, pid} = GoodFetcher.start_link(http: HttpClient)
    assert GoodFetcher.fetch(pid, "http://ya.ru") == "url: http://ya.ru"
  end

  test "fetch, doppler http client double" do
    http = Doppler.start(nil)
    Doppler.def(http, :get!, fn(st, url) -> { %{body: "url: #{url}"}, st} end)

    {:ok, pid} = GoodFetcher.start_link(http: http)
    assert GoodFetcher.fetch(pid, "http://ya.ru") == "url: http://ya.ru"
  end

  test "fetch, Stubr http client double" do
    http = Stubr.stub!([get!: &%{body: "url: #{&1}"}])

    {:ok, pid} = GoodFetcher.start_link(http: http)
    assert GoodFetcher.fetch(pid, "http://ya.ru") == "url: http://ya.ru"
  end
end
