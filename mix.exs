defmodule Rayex.MixProject do
  use Mix.Project

  def project do
    [
      app: :rayex,
      version: "0.0.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      compilers: [:unifex, :bundlex] ++ Mix.compilers(),
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]],
      docs: fn ->
        {result, _} = Code.eval_file("docs.exs")
        result
      end
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
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
