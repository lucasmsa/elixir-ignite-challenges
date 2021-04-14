defmodule GithubConsumerWeb.UsersController do
  use GithubConsumerWeb, :controller
  alias GithubConsumer.User
  alias GithubConsumerWeb.ErrorView
  alias GithubConsumerWeb.Auth.Guardian

  def create(conn, params) do
    with {:ok, %User{} = user} <- GithubConsumer.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user, token: token)
    else
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- GithubConsumer.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    else
      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end

  def signin(conn, %{"id" => id, "password" => password}) do
    with {:ok, %User{} = user, token} <-
           Guardian.authenticate(%{"id" => id, "password" => password}) do
      conn
      |> put_status(:ok)
      |> render("signin.json", user: user, token: token)
    else
      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end
end
