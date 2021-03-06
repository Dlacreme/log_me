defmodule LogMe.MixProject do
  use Mix.Project

  def project do
    [
      app: :log_me,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {LogMe.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Core
      {:plug_cowboy, "~> 2.5"},
      {:phoenix, "~> 1.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.16.0"},
      {:phoenix_live_dashboard, "~> 0.5"},
      # Hosting
      {:cors_plug, "~> 2.0"},
      # Database
      {:postgrex, ">= 0.0.0"},
      {:ecto_sql, "~> 3.6"},
      # Mailing
      {:swoosh, "~> 1.3"},
      # Format & validation
      {:bcrypt_elixir, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.0"},
      {:ex_phone_number, "~> 0.2"},
      # Languages
      {:gettext, "~> 0.18"},
      # Front-end
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.2", runtime: Mix.env() == :dev},
      # Code analysis
      {:credo, "1.5.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      # Others
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["cmd --cd assets npm run build", "phx.digest"]
    ]
  end
end
