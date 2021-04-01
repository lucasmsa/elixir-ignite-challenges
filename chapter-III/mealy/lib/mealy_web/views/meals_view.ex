defmodule MealyWeb.MealsView do
  use MealyWeb, :view

  def render("create.json", %{meal: meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end

  def render("meal.json", %{meal: meal}), do: %{meal: meal}
end
