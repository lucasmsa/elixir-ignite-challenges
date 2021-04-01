defmodule Mealy.Meals.DeleteTest do
  use Mealy.DataCase, async: true
  alias Ecto.Changeset
  alias Mealy.Error
  alias Mealy.Meal
  alias Mealy.Meals.Delete
  import Mealy.Factory

  describe "call/1" do
    test "Deletes the user if he/she exists" do
      insert(build(:meal, %{id: "c576dd34-d96b-4a02-aca8-f304c32d9269"}))
      response = Delete.call("c576dd34-d96b-4a02-aca8-f304c32d9269")

      assert {:ok,
              %Meal{description: "Temaki no pão", id: "c576dd34-d96b-4a02-aca8-f304c32d9269"}} =
               response
    end

    test "returns an error if the user does not exist" do
      response = Delete.call("c576dd34-d96b-4a02-aca8-f304c32d9264")

      assert {:error, %Error{reason: "User not found!", status: :im_a_teapot}} == response
    end
  end
end
