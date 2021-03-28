defmodule Mealy.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:description, :date, :calories]
  @derive {Jason.Encoder, only: [:id, :calories, :date, :description]}

  schema "meals" do
    field(:description, :string)
    field(:date, :naive_datetime)
    field(:calories, :float)

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:calories, less_than_or_equal_to: 1000.0)
    |> validate_length(:description, max: 1000)
  end
end
