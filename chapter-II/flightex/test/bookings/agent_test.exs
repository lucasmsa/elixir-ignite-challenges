defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  describe "save/1" do
    test "saves the booking" do
      BookingAgent.start_link()
      response = BookingAgent.save(build(:booking))

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "Gets the booking on the Agent if the booking is saved on it" do
      BookingAgent.save(build(:booking, id: "29832209"))
      response = BookingAgent.get("29832209")

      expected_response =
        {:ok,
         %Flightex.Bookings.Booking{
           cidade_destino: "rj",
           cidade_origem: "sp",
           data_completa: ~N[2000-01-13 23:00:07.005],
           id: "29832209",
           id_usuario: "89e73283728"
         }}

      assert response == expected_response
    end

    test "Returns an error if the booking was never created" do
      response = BookingAgent.get("bananotelli")
      expected_response = {:error, "Flight Booking not found"}
      assert response == expected_response
    end
  end
end
