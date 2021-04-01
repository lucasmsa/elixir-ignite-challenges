defmodule Mealy.Meals.Get do
  alias Mealy.{Meal, Repo}
  alias Mealy.Error

  def call(id) do
    Repo.get(Meal, id) |> handle_get()
  end

  defp handle_get(%Meal{} = meal), do: {:ok, meal}

  defp handle_get(nil), do: {:error, Error.user_not_found_error()}
end
