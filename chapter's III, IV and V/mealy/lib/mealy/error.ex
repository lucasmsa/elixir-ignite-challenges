defmodule Mealy.Error do
  @keys [:status, :reason]
  @enforce_keys @keys
  defstruct @keys

  def build(status, reason) do
    %__MODULE__{
      status: status,
      reason: reason
    }
  end

  def user_not_found_error, do: build(:im_a_teapot, "User not found!")
  def meal_not_found_error, do: build(:im_a_teapot, "Meal not found!")
end
