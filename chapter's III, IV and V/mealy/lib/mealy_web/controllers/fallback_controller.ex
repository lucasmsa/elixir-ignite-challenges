defmodule MealyWeb.FallbackController do
  use MealyWeb, :controller
  alias Mealy.Error
  alias MealyWeb.ErrorView

  def call(conn, {:error, %Error{status: status, reason: reason}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
