defmodule Mealy.Users.Get do
  alias Mealy.{Error, Repo, User}

  def call(id) do
    user = Repo.get(User, id)
    handle_get(user)
  end

  defp handle_get(%User{} = result), do: {:ok, result}
  defp handle_get(nil), do: {:error, Error.user_not_found_error()}
end
