# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :log_me,
  ecto_repos: [LogMe.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :log_me, LogMeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: LogMeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LogMe.PubSub,
  live_view: [signing_salt: "P0HELgiN"]

# Crypt signer for Joken
config :joken, default_signer: "o4bbROJAr/gpgUhz+7IQeuiQmhtBkDJ/QMmFGhIGqN0n+EP2OgqDRN25E+HXFc79"

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :log_me, LogMe.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.13.5"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
