defmodule GithubConsumerWeb.ClientController do
  use GithubConsumerWeb, :controller
  alias GithubConsumerWeb.ErrorView

  def show(conn, %{"username" => username}) do
    with {:ok, repositories_info} <- GithubConsumer.get_user_repo_info(username) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repos: repositories_info)
    else
      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("error.json", reason: reason)
    end
  end
end
