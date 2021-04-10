defmodule GithubConsumer.Repo do
  use Ecto.Repo,
    otp_app: :github_consumer,
    adapter: Ecto.Adapters.Postgres
end
