defmodule MealyWeb.Plugs.UUIDChecker do
  import Plug.Conn
  alias Ecto.UUID
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(%Conn{params: %{"user_id" => user_id}} = conn, _opts) do
    case UUID.cast(user_id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  def call(%Conn{params: %{"user_id" => user_id, "id" => id}} = conn, _opts) do
    with {:ok, _uuid} <- UUID.cast(id),
         {:ok, _uuid} <- UUID.cast(user_id) do
      conn
    else
      _error -> render_error(conn)
    end
  end

  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "ID is not an UUID"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
