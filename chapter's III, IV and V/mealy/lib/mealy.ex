defmodule Mealy do
  alias Mealy.Meals.{Create, Delete, Get, Update}
  alias Mealy.Users.Create, as: CreateUser
  alias Mealy.Users.Get, as: GetUser
  alias Mealy.Users.Delete, as: DeleteUser

  defdelegate create_meal(params), to: Create, as: :call
  defdelegate get_meal(id), to: Get, as: :call
  defdelegate delete_meal(id), to: Delete, as: :call
  defdelegate update_meal(params), to: Update, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user(id), to: GetUser, as: :call
  defdelegate delete_user(id), to: DeleteUser, as: :call
end
