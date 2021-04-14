defmodule GithubConsumer.Users.Get do
  alias GithubConsumer.{User, Repo}

  def call(id) do
    user = Repo.get(User, id)
    handle_get(user)
  end

  defp handle_get(nil), do: {:error, "User not found!"}

  defp handle_get(%User{} = user), do: {:ok, user}
end
