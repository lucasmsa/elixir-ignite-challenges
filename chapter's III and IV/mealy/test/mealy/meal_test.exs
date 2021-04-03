defmodule Mealy.MealTest do
  use Mealy.DataCase, async: true
  alias Ecto.Changeset
  alias Mealy.Meal

  describe "changeset/2" do
    test "if all changeset parameters are valid, returns a valid changeset" do
      params = %{
        description: "Batata de bacon",
        calories: 120.5,
        date: ~N[2021-02-13 21:00:07]
      }

      response = Meal.changeset(params)

      assert %Changeset{
               changes: %{
                 calories: 120.5,
                 date: ~N[2021-02-13 21:00:07],
                 description: "Batata de bacon"
               },
               valid?: true
             } = response
    end

    test "updates a changeset if the changeset exists" do
      original_params = %{
        description: "Batata de bacon",
        calories: 130.0,
        date: ~N[2021-02-13 21:00:07]
      }

      meal = Meal.changeset(original_params)

      new_params = %{
        description: "Sushi de hambúrguer",
        calories: 280.0
      }

      response = Meal.changeset(meal, new_params)

      assert %Changeset{
               changes: %{
                 calories: 280.0,
                 description: "Sushi de hambúrguer"
               },
               valid?: true
             } = response
    end

    test "if some parameter is invalid, returns an invalid changeset" do
      params = %{
        description: "Batata de bacon",
        calories: 130.0,
        date: "datosa"
      }

      response = Meal.changeset(params)

      expected_response = %{
        date: ["is invalid"]
      }

      assert expected_response == errors_on(response)
    end
  end
end
