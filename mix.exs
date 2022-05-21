defmodule AWS.MixProject do
  use Mix.Project

  def project do
    [
      app: :aws,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sigaws, "~> 0.7"},
      {:finch, "~> 0.12"},
      {:ini, "~> 1.0"},
      {:uuid, "~> 1.1" }
    ]
  end
end
