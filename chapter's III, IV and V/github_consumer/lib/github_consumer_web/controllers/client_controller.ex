defmodule GithubConsumerWeb.ClientController do
  use GithubConsumerWeb, :controller
  alias GithubConsumerWeb.ErrorView
  alias GithubConsumerWeb.Auth.Guardian

  def show(conn, %{"username" => username}) do
    current_token = Guardian.Plug.current_token(conn)

    with {:ok, repositories_info} <- GithubConsumer.get_user_repo_info(username),
         {:ok, _old_stuff, {new_token, _new_claims}} =
           Guardian.refresh(current_token, ttl: {1, :minute}) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repos: repositories_info, refresh_token: new_token)
    else
      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end
end
