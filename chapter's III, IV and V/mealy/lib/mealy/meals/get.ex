defmodule Mealy.Meals.Get do
  alias Mealy.{Error, Meal, Repo}

  def call(id) do
    meal = Repo.get(Meal, id)
    handle_get(meal)
  end

  defp handle_get(%Meal{} = meal), do: {:ok, meal}

  defp handle_get(nil), do: {:error, Error.meal_not_found_error()}
end
