defmodule Mealy.Users.Create do
  alias Mealy.{Error, Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, _user} = result), do: result

  defp handle_insert({:error, reason}) do
    {:error, %Error{status: :bad_request, reason: reason}}
  end
end
