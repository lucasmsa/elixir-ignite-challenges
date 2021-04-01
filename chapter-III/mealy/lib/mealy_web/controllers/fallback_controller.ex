defmodule MealyWeb.FallbackController do
  use MealyWeb, :controller
  alias MealyWeb.ErrorView
  alias Mealy.Error

  def call(conn, {:error, %Error{status: status, reason: reason}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
