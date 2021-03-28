defmodule Mealy do
  alias Mealy.Meals.{Create}

  defdelegate create_meal(params), to: Create, as: :call
  # defdelegate delete_meal(params), to: Delete, as: :call
  # defdelegate update_meal(params), to: Update, as: :call
  # defdelegate get_meal(params), to: Get, as: :call
end
