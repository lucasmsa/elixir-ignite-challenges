defmodule GithubConsumerWeb.UsersController do
  use GithubConsumerWeb, :controller
  alias GithubConsumer.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- GithubConsumer.create_user(params) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    else
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end
end
