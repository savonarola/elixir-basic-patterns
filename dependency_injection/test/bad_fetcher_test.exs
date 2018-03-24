defmodule BadFetcherTest do
  use ExUnit.Case

  import Mock

  test "fetch, Stubr HTTPoison stub" do
    {:ok, pid} = BadFetcher.start_link([])

    with_mock HTTPoison, [get!: &%{body: "url: #{&1}"}] do
      assert BadFetcher.fetch(pid, "http://ya.ru") == "url: http://ya.ru"
    end
  end
end
