defmodule Mealy.Meals.CreateTest do
  use Mealy.DataCase, async: true
  alias Ecto.Changeset
  alias Mealy.Error
  alias Mealy.Meal
  alias Mealy.Meals.Create
  import Mealy.Factory

  describe "call/1" do
    test "creates an user if all parameters are valid" do
      params = build(:meal_params, %{description: "Pizza"})
      response = Create.call(params)

      assert {:ok,
              %Meal{
                calories: 200.0,
                date: ~N[2021-02-16 22:00:00],
                description: "Pizza"
              }} = response
    end

    test "returns an error if there are invalid parameters" do
      {:error, %Error{reason: %Error{reason: %Changeset{} = response}}} =
        Create.call(build(:meal_params, %{date: "datastica"}))

      assert %{date: ["is invalid"]} == errors_on(response)
    end
  end
end
