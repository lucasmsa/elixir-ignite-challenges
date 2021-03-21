defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking, as: Booking

  def create(filename, %NaiveDateTime{} = from_date, %NaiveDateTime{} = to_date) do
    formatted_flights = fetch_available_flights(from_date, to_date)
    File.write(filename, formatted_flights)
    {:ok, "Report generated successfully"}
  end

  def create(_filename, _from_date, _to_date) do
    {:error, "Report could not be generated because dates aren't in the correct format"}
  end

  defp fetch_available_flights(from_date, to_date) do
    BookingAgent.list()
    |> filter_flight_dates(from_date, to_date)
    |> format_flights()
  end

  defp format_flights(flights) do
    Enum.map(flights, fn {_id,
                          %Flightex.Bookings.Booking{
                            cidade_origem: origin,
                            cidade_destino: destination,
                            data_completa: date,
                            id_usuario: user_id
                          }} = _flight ->
      "#{user_id},#{origin},#{destination},#{date}\n"
    end)
  end

  defp filter_flight_dates(flights, from_date, to_date) do
    Enum.filter(flights, fn {_id, %Booking{data_completa: date}} = _flight ->
      handle_date_comparison(date, from_date, to_date)
    end)
  end

  defp handle_date_comparison(date, lower_bound, upper_bound) do
    case NaiveDateTime.compare(date, lower_bound) do
      :gt -> handle_upper_bound(date, upper_bound)
      :eq -> handle_upper_bound(date, upper_bound)
      :lt -> false
    end
  end

  defp handle_upper_bound(date, upper_bound) do
    case NaiveDateTime.compare(date, upper_bound) do
      :lt -> true
      :eq -> true
      :gt -> false
    end
  end
end
