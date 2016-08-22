defmodule Contver.Mixfile do
  use Mix.Project

  def project do
    [app: :contver,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      applications: 
      [
        :logger,
        :yaml_elixir,
      ]
    ]
  end

  defp deps do
    [
      { :yaml_elixir, "~> 1.2.0" },
      { :yamerl, "~> 0.3.2" },
    ]
  end
end
