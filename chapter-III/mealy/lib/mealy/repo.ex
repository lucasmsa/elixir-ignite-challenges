defmodule Mealy.Repo do
  use Ecto.Repo,
    otp_app: :mealy,
    adapter: Ecto.Adapters.Postgres
end
