defmodule Mealy.Meals.Create do
  alias Mealy.{Meal, Repo}

  def call(%{date: date} = params) do
    date = parse_date(date)

    %{params | date: date}
    |> Meal.changeset()
    |> Repo.insert()
  end

  defp parse_date(%NaiveDateTime{} = date), do: date

  defp parse_date(Sting = date) do
    with {:ok, %NaiveDateTime{} = naive_date} <- NaiveDateTime.from_iso8601(date) do
      naive_date
    else
      error -> error
    end
  end
end
