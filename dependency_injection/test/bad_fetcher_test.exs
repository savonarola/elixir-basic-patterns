defmodule BadFetcherTest do
  use ExUnit.Case

  import Mock

  test "fetch, Stubr HTTPoison stub" do
    {:ok, pid} = GoodFetcher.start_link()

    with_mock HTTPoison, [get!: &%{body: "url: #{&1}"}] do
      assert GoodFetcher.fetch(pid, "http://ya.ru") == "url: http://ya.ru"
    end
  end
end
