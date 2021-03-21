defmodule Flightex.Users.CreateUserTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateUser
  alias Flightex.Users.User

  describe "call/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "creates the user if all parameters are valid" do
      assert {:ok, user_id} =
               CreateUser.call(%{email: "bana@na.com", name: "lucos", cpf: "0921929"})
    end

    test "returns an error if the cpf is invalid" do
      assert {:error, reason} = CreateUser.call(%{email: "bana@na.com", name: "lucos", cpf: 12})
    end
  end
end
