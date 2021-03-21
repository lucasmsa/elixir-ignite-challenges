defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  describe "build/4" do
    setup do
      %User{id: user_id} = build(:user)

      {:ok, user_id: user_id}
    end

    test "if provided the correct parameters, creates the booking", %{user_id: user_id} do
      {:ok, response} = Booking.build(~N[2000-01-13 23:00:07.005], "sp", "rj", user_id)

      expected_response = build(:booking, id: response.id, id_usuario: user_id)

      assert response == expected_response
    end

    test "if provided a wrong date format, returns an error", %{user_id: user_id} do
      response = Booking.build("batata?", "jp", "re", user_id)
      expected_response = {:error, "Invalid parameters 🦥"}

      assert response == expected_response
    end
  end
end
