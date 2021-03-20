defmodule Flightex.Users.CreateUser do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{email: email, name: name, cpf: cpf}) do
    case User.build(email, name, cpf) do
      {:ok, user} ->
        UserAgent.save(user)
        {:ok, user.id}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
