defmodule MealyWeb.MealyWeb.MealsController do
  use MealyWeb, :controller
  alias Mealy.Meal

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Mealy.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("meal.json", meal: meal)
    else
      error -> error
    end
  end
end
