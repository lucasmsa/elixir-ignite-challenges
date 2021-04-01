defmodule Mealy.Meals.Update do
  alias Mealy.Repo
  alias Mealy.{Error, Meal}

  def call(%{id: id} = params) do
    case Repo.get(Meal, id) do
      nil ->
        {:error, Error.user_not_found_error()}

      meal ->
        Meal.changeset(meal, params) |> Repo.update()
    end
  end
end
