defmodule Mealy.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:name, :email, :cpf]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:cpf, :string)
    has_many(:meals, Mealy.Meal)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint(:cpf)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
    |> validate_length(:name, greater_than: 2)
  end
end
