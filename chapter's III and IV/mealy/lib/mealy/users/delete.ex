defmodule Mealy.Users.Delete do
  alias Mealy.Repo
  alias Mealy.{Error, Meal, User}
  import Ecto.Query

  def call(id) do
    case Repo.get(User, id) do
      nil ->
        {:error, Error.user_not_found_error()}

      user ->
        query = from meal in Meal, where: meal.user_id == ^id
        Repo.delete_all(query)
        Repo.delete(user)
    end
  end
end
