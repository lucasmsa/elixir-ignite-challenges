defmodule Mealy.Meals.UpdateTest do
  use Mealy.DataCase, async: true
  alias Ecto.Changeset
  alias Mealy.Error
  alias Mealy.Meal
  alias Mealy.Meals.Update
  import Mealy.Factory

  describe "call/1" do
    test "updates an user if the user exists and all parameters are valid" do
      insert(build(:meal, %{id: "c576dd34-d96b-4a02-aca8-f304c32d9269"}))

      params = %{
        id: "c576dd34-d96b-4a02-aca8-f304c32d9269",
        description: "batata",
        calories: 203.42
      }

      response = Update.call(params)

      assert {:ok,
              %Meal{
                id: "c576dd34-d96b-4a02-aca8-f304c32d9269",
                calories: 203.42,
                description: "batata"
              }} = response
    end

    test "returns an error if the user does not exist" do
      response =
        Update.call(%{
          id: "c576dd34-d96b-4a02-aca8-f304c32d9261",
          description: "bananinha",
          calories: 100.0
        })

      assert {:error, %Error{reason: "User not found!", status: :im_a_teapot}} == response
    end

    test "returns an error if the parameters are invalid" do
      insert(build(:meal, %{id: "c576dd34-d96b-4a02-aca8-f304c32d9269"}))

      {:error, %Changeset{} = response} =
        Update.call(%{
          id: "c576dd34-d96b-4a02-aca8-f304c32d9269",
          description: "bananinha",
          calories: 100.0,
          date: "datinhaaa"
        })

      assert %{date: ["is invalid"]} == errors_on(response)
    end
  end
end
