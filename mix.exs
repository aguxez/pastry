defmodule Pastry.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pastry,
      version: "0.2.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: pkg(),
      description: description(),
      name: "Pastry",
      source_url: "https://github.com/aguxez/pastry"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Pastry.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp pkg do
    [
      files: ~w(lib mix.exs README*),
      maintainers: ["Miguel Diaz"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/aguxez/pastry"}
    ]
  end

  defp description do
    "Turn maps and keyword lists into query strings"
  end
end
