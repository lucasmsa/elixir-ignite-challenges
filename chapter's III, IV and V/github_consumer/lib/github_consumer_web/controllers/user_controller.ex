defmodule GithubConsumerWeb.UsersController do
  use GithubConsumerWeb, :controller
  alias GithubConsumer.User
  alias GithubConsumerWeb.ErrorView
  alias GithubConsumerWeb.Auth.Guardian

  def create(conn, params) do
    with {:ok, %User{} = user} <- GithubConsumer.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}) do
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
    current_token = Guardian.Plug.current_token(conn)

    with {:ok, %User{} = user} <- GithubConsumer.get_user(id),
         {:ok, _old_stuff, {new_token, _new_claims}} =
           Guardian.refresh(current_token, ttl: {1, :minute}) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user, refresh_token: new_token)
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
