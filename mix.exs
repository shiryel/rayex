defmodule Rayex.MixProject do
  use Mix.Project

  def project do
    [
      app: :rayex,
      version: "0.0.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      compilers: [:unifex, :bundlex] ++ Mix.compilers,
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Rayex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # CI
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      # Deps
      {:unifex, "~> 0.7.0"}
    ]
  end
end
