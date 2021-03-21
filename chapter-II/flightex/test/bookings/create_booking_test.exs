defmodule Flightex.Booking.CreateBookingTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      UserAgent.start_link()
      BookingAgent.start_link()

      :ok
    end

    test "creates the booking if all parameters are valid, and the user exists" do
      UserAgent.save(build(:user, id: "123456"))

      assert {:ok, booking_id} =
               CreateBooking.call("123456", %{
                 data_completa: ~N[2000-01-01 23:00:07],
                 cidade_origem: "sp",
                 cidade_destino: "rj"
               })
    end

    test "returns an error if the cpf is invalid" do
      assert {:error, "User not found"} ==
               CreateBooking.call("123456", %{
                 data_completa: ~N[2000-01-01 23:00:07],
                 cidade_origem: "sp",
                 cidade_destino: "rj"
               })
    end

    test "returns an error if the date is not on a valid format" do
      UserAgent.save(build(:user, id: "123456"))

      assert {:error, "Invalid parameters 🦥"} ==
               CreateBooking.call("123456", %{
                 data_completa: "banana",
                 cidade_origem: "sp",
                 cidade_destino: "rj"
               })
    end
  end
end
