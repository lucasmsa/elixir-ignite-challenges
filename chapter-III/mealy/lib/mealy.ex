defmodule Mealy do
  alias Mealy.Meals.{Create, Get, Delete, Update}

  defdelegate create_meal(params), to: Create, as: :call
  defdelegate get_meal(id), to: Get, as: :call
  defdelegate delete_meal(id), to: Delete, as: :call
  defdelegate update_meal(params), to: Update, as: :call
end
