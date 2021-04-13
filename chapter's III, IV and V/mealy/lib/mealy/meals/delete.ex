defmodule Mealy.Meals.Delete do
  alias Mealy.Repo
  alias Mealy.{Error, Meal}

  def call(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.meal_not_found_error()}
      meal -> Repo.delete(meal)
    end
  end
end
