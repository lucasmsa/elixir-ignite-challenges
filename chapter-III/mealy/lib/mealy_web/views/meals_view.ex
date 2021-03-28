defmodule MealyWeb.MealyWeb.MealsView do
  use MealyWeb, :view

  def render("meal.json", %{meal: meal}) do
    %{
      message: "Meal created!",
      meal: meal
    }
  end
end
