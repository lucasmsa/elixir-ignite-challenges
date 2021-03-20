defmodule Flightex.Bookings.CreateBooking do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(id_usuario, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do
    with {:ok, _user} <- UserAgent.get(id_usuario),
         {:ok, booking} <- Booking.build(data_completa, cidade_origem, cidade_destino, id_usuario) do
      BookingAgent.save(booking)
      {:ok, booking.id}
    else
      error -> error
    end
  end
end
