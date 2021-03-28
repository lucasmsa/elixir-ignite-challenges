# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mealy,
  ecto_repos: [Mealy.Repo]

config :mealy, Mealy.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :mealy, MealyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eqphsilLyuoRpguIw9ML6giOFRtQsYzmCFkzuvSIVGALsj0PucRa8/5cZl1IlkyM",
  render_errors: [view: MealyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mealy.PubSub,
  live_view: [signing_salt: "FhFuK/B7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
