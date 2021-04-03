defmodule Mealy.Factory do
  use ExMachina.Ecto, repo: Mealy.Repo
  alias Mealy.Meal

  def meal_params_factory() do
    %{
      calories: 200.0,
      description: "Hamburgão",
      date: ~N[2021-02-16 22:00:00]
    }
  end

  def meal_factory() do
    %Meal{
      id: "7394fd80-41a0-431f-b8c7-e15f83129d8a",
      calories: 110.0,
      description: "Temaki no pão",
      date: ~N[2020-04-16 22:00:00]
    }
  end
end
