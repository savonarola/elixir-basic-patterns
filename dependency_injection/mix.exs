defmodule Patterns.Mixfile do
  use Mix.Project

  def project do
    [app: :patterns,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      mod: {Patterns, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10.0"},
      {:doppler, "~> 0.1.0", only: :test},
      {:stubr, "~> 1.5.0", only: :test},
      {:mock, "~> 0.2.0", only: :test},
      {:poolboy, "~> 1.5"}
    ]
  end
end
