defmodule GithubConsumerWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {error_type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error_type)})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
