defmodule QyCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :qy_core,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: []
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {QyCore.Application, []}
    ]
  end
end
