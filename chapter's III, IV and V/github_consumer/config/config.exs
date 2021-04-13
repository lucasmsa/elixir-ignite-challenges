# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_consumer,
  ecto_repos: [GithubConsumer.Repo]

config :github_consumer, GithubConsumer.Repo, migration_primary_key: [type: :binary_id]

# Configures the endpoint
config :github_consumer, GithubConsumerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+GamziSOOghHWeL4M09+rQNkAo+uOmRIaV1yFrU/VJ/vmmgGMr26yMH7wIZfEuGO",
  render_errors: [view: GithubConsumerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GithubConsumer.PubSub,
  live_view: [signing_salt: "b96VURIz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
