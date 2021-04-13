defmodule GithubConsumer.Users.Create do
  alias GithubConsumer.{User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = user), do: user

  defp handle_insert({:error, _reason} = error), do: error
end
