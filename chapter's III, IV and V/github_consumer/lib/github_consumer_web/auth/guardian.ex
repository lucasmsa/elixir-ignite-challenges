defmodule GithubConsumerWeb.Auth.Guardian do
  use Guardian, otp_app: :github_consumer
  alias GithubConsumer.User

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = GithubConsumer.get_user(id)

    {:ok, user}
  end

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{} = user} <- GithubConsumer.get_user(id),
         true <- Pbkdf2.verify_pass(password, user.password_hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, user, token}
    else
      false -> {:error, "Passwords do not match!"}
      error -> error
    end
  end

  def authenticate(_params), do: {:error, "Invalid parameters ⻱"}
end
