defmodule Mealy.Meals.Create do
  alias Mealy.{Error, Meal, Repo}

  def call(%{"date" => date} = params) do
    date = parse_date(date)

    %{params | "date" => date}
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _meal} = result), do: result

  defp handle_insert({:error, reason}) do
    {:error, %Error{status: :bad_request, reason: reason}}
  end

  defp parse_date(%NaiveDateTime{} = date), do: date

  defp parse_date(date) do
    with {:ok, %NaiveDateTime{} = naive_date} <- NaiveDateTime.from_iso8601(date) do
      naive_date
    else
      error -> error
    end
  end
end
