defmodule Flightex.Users.UserTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Users.User

  describe "build/3" do
    test "if provided the correct parameters, creates the user" do
      {:ok, response} = User.build("lucas@email.com", "lucas", "923083912")

      expected_response = build(:user, id: response.id)

      assert response == expected_response
    end

    test "if the cpf is not a string, returns an error" do
      response = User.build("lucas@email.com", "lucas", 12)
      expected_response = {:error, "Invalid parameters 🍇"}

      assert response == expected_response
    end
  end
end
