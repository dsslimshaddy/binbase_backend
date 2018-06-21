# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :binbase_backend,
  ecto_repos: [BinbaseBackend.Repo]

# Configures the endpoint
config :binbase_backend, BinbaseBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MQ4LNiBYgto/Cnln3X8U59fy08xrzH76t3wd16Ewj6VgA+2QQciw9FQqYSlfX1Zv",
  render_errors: [view: BinbaseBackendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BinbaseBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
