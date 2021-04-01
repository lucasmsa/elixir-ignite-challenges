defmodule Mealy.Meals.Delete do
  alias Mealy.Repo
  alias Mealy.{Meal, Error}

  def call(id) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.user_not_found_error()}
      meal -> Repo.delete(meal)
    end
  end
end
