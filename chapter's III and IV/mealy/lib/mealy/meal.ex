defmodule Mealy.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:description, :date, :calories, :user_id]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "meals" do
    field(:description, :string)
    field(:date, :naive_datetime)
    field(:calories, :float)
    belongs_to(:user, Mealy.User)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:calories, less_than_or_equal_to: 1000.0)
    |> validate_length(:description, max: 1000)
  end
end
