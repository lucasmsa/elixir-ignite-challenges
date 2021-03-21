defmodule Flightex.Users.AgentTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link()
      response = UserAgent.save(build(:user))

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "Gets the user on the agent if the user is saved on the Agent" do
      UserAgent.save(build(:user, id: "29832209"))
      response = UserAgent.get("29832209")

      expected_response =
        {:ok,
         %User{
           cpf: "923083912",
           email: "lucas@email.com",
           id: "29832209",
           name: "lucas"
         }}

      assert response == expected_response
    end

    test "Returns an error if the user was never created" do
      response = UserAgent.get("bananotelli")
      expected_response = {:error, "User not found"}
      assert response == expected_response
    end
  end
end
