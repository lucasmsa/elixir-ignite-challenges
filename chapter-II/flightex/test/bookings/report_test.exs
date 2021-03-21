defmodule Flightex.Booking.ReportTest do
  use ExUnit.Case
  import Flightex.Factory
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent

  describe "create/3" do
    setup do
      UserAgent.start_link()
      BookingAgent.start_link()

      :ok
    end

    test "returns a list of flights between 2 dates and saves it to a file" do
      UserAgent.save(build(:user, id: "123456"))

      {:ok, booking_id1} =
        CreateBooking.call("123456", %{
          data_completa: ~N[2000-01-01 21:00:07],
          cidade_origem: "sp",
          cidade_destino: "rj"
        })

      {:ok, booking_id2} =
        CreateBooking.call("123456", %{
          data_completa: ~N[2000-01-01 22:00:07],
          cidade_origem: "sp",
          cidade_destino: "rj"
        })

      {:ok, booking_id3} =
        CreateBooking.call("123456", %{
          data_completa: ~N[2000-01-01 23:30:07],
          cidade_origem: "sp",
          cidade_destino: "rj"
        })

      Report.create("report_test.csv", ~N[2000-01-01 20:00:07], ~N[2000-01-01 23:30:07])
      response = File.read!("report_test.csv")

      expected_response =
        "123456,sp,rj,2000-01-01 22:00:07\n123456,sp,rj,2000-01-01 21:00:07\n123456,sp,rj,2000-01-01 23:30:07\n"

      assert Enum.sort(String.split(response, "\n")) ==
               Enum.sort(String.split(expected_response, "\n"))
    end

    test "returns an error if dates are not in the correct format" do
      response = Report.create("report_test.csv", "timo", "werner")

      assert {:error, "Report could not be generated because dates aren't in the correct format"} ==
               response
    end
  end
end
