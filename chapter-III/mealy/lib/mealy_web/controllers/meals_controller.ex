defmodule MealyWeb.MealsController do
  use MealyWeb, :controller
  alias Mealy.Meal

  action_fallback(MealyWeb.FallbackController)

  def create(conn, params) do
    params = for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}

    with {:ok, %Meal{} = meal} <- Mealy.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    else
      error -> error
    end
  end

  def show(conn, %{"id" => id} = _params) do
    with {:ok, %Meal{} = meal} <- Mealy.get_meal(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    else
      error -> error
    end
  end

  def delete(conn, %{"id" => id} = _params) do
    with {:ok, %Meal{}} <- Mealy.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    else
      error -> error
    end
  end

  def update(conn, params) do
    params = for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}

    with {:ok, %Meal{} = meal} <- Mealy.update_meal(params) do
      conn
      |> put_status(:accepted)
      |> render("meal.json", meal: meal)
    else
      error -> error
    end
  end
end
