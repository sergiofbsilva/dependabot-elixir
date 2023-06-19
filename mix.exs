defmodule MyApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_api,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {MyApi.Application, []},
      extra_applications: extra_applications(Mix.env())
    ]
  end

  defp extra_applications(:prod), do: [:logger, :runtime_tools, :api_gw_req_verifier]
  defp extra_applications(_), do: [:logger, :runtime_tools, :hackney]

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:confex, "~> 3.4"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:distillery, "~> 2.1"},
      {:ecto_sql, "~> 3.3"},
      {:elixir_uuid, "~> 1.2"},
      {:excoveralls, "~> 0.12", only: :test},
      {:jason, "~> 1.1"},
      {:mox, "~> 0.5", only: :test},
      {:new_relic_agent, "~> 1.27.7"},
      {:phoenix, "~> 1.7.6"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, "~> 0.15"},
      {:telemetry, "~> 0.4"},
    ]
  end

  defp aliases do
    [
      test: ["format --check-formatted", "ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
