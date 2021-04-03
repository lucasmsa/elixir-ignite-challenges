defmodule MealyWeb.UsersController do
  use MealyWeb, :controller
  alias Mealy.User

  action_fallback(MealyWeb.FallbackController)

  def create(conn, params) do
    with {:ok, %User{} = user} <- Mealy.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    else
      error -> error
    end
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, %User{} = user} <- Mealy.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    else
      error -> error
    end
  end

  def delete(conn, %{"id" => id} = _params) do
    with {:ok, %User{}} <- Mealy.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    else
      error -> error
    end
  end
end
