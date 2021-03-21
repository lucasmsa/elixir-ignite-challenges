defmodule Flightex.Factory do
  use ExMachina
  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory() do
    uuid = UUID.uuid4()

    %User{
      id: uuid,
      cpf: "923083912",
      email: "lucas@email.com",
      name: "lucas"
    }
  end

  def booking_factory() do
    uuid = UUID.uuid4()
    {:ok, date} = NaiveDateTime.new(~D[2000-01-13], ~T[23:00:07.005])

    %Booking{
      id: uuid,
      data_completa: date,
      cidade_origem: "sp",
      cidade_destino: "rj",
      id_usuario: "89e73283728"
    }
  end
end
