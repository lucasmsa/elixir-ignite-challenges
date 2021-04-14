defmodule GithubConsumerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :github_consumer

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
