defmodule GithubConsumer.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  import Pbkdf2

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Changeset{changes: %{password: password}, valid?: true} = changeset) do
    change(changeset, add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
