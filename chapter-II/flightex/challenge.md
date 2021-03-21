- [x]  Create `User`, fields: `id`, `email`, `name`, `cpf`
    - `id` must be generated automatically, and may never be repeated

- [x]  Create `Booking`, fields: `id` , `data_completa` , `cidade_origem` , `cidade_destino` , `id_usuario`
    - `data_completa` must be a  [`NaiveDateTime`](https://hexdocs.pm/elixir/NaiveDateTime.html#content)
- Desired output

```elixir
iex> Flightex.create_user(params)
...> {:ok, user_id}

iex> Flightex.create_booking(user_id, params)
...> {:ok, booking_id}

iex> Flightex.create_booking(invalid_user_id, params)
...> {:error, "User not found"}

iex> Flightex.get_booking(booking_id)
...> {:ok, %Booking{...}}

iex> Flightex.get_booking(invalid_booking_id)
...> {:error, "Flight Booking not found"}
```

- [x]  Generate flight reports
    - Pass in 2 parameters to the function, `from_date` , `to_date` , where all bookings made between those dates should be inside the report
- [x]  Test every module of the application