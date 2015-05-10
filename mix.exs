defmodule Marvel.Mixfile do
  use Mix.Project

  def project do
    [
      app: :marvel,
      version: "0.4.0",
      elixir: "~> 1.0",
      escript: escript_config,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package,
      description: description
    ]
  end

  defp description do
    """
    Marvel CLI Client
    """
  end

  defp escript_config do
    [main_module: Marvel.CLI, name: "marvel"]
  end

  def application do
    [applications: [:logger, :poison, :httpoison]]
  end

  defp deps do
    [
      { :poison, "~> 1.4" },
      { :httpoison, "~> 0.6"},
      { :timex, "~> 0.13.4"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      { :excoveralls, only: [:dev, :test] },
      { :shouldi, github: "batate/shouldi", only: :test }
    ]
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "CHANGELOG*", "marvel"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ 
        "GitHub" => "https://github.com/bryanjos/marvel"
      }
    ]
  end
end
