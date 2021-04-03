defmodule Mealy.Meals.Update do
  alias Mealy.Repo
  alias Mealy.{Error, Meal}

  def call(%{user_id: _user_id} = _params) do
    {:error,
     Error.build(:bad_request, "You may not change the user's ID after the order has been made")}
  end

  def call(params) do
    case Repo.get(Meal, params.id) do
      nil ->
        {:error, Error.meal_not_found_error()}

      meal ->
        Meal.changeset(meal, params) |> Repo.update()
    end
  end
end
