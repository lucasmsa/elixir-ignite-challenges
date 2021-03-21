defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> get_booking(state, id) end)
  end

  def list() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, fn state -> update_booking(state, id, booking) end)
  end

  defp update_booking(state, id, booking) do
    Map.put(state, id, booking)
  end
end
