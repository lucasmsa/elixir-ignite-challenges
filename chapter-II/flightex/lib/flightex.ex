defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateUser

  def start_agents() do
    UserAgent.start_link()
    BookingAgent.start_link()
  end

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate create_booking(user_id, params), to: CreateBooking, as: :call
  defdelegate get_booking(booking_id), to: BookingAgent, as: :get
  defdelegate generate_report(filename, from_date, to_date), to: Report, as: :create
end
