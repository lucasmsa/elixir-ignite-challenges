defmodule Mealy.Meals.GetTest do
  use Mealy.DataCase, async: true
  alias Mealy.Meal
  alias Mealy.Meals.Get
  import Mealy.Factory

  describe "call/1" do
    test "if the user exists in the db returns the user" do
      insert(build(:meal, %{id: "c576dd34-d96b-4a02-aca8-f304c32d9269"}))
      response = Get.call("c576dd34-d96b-4a02-aca8-f304c32d9269")

      assert {:ok,
              %Meal{
                calories: 110.0,
                date: ~N[2020-04-16 22:00:00],
                description: "Temaki no pão",
                id: "c576dd34-d96b-4a02-aca8-f304c32d9269"
              }} = response
    end

    test "if the user does not exist, returns an user not found error" do
      response = Get.call("785d6dee-bd31-467a-b9b1-3d7804e8acbd")

      assert {
               :error,
               %Mealy.Error{
                 reason: "User not found!",
                 status: :im_a_teapot
               }
             } == response
    end
  end
end
