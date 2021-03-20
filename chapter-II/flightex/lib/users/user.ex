defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(email, name, cpf) when is_bitstring(cpf) do
    uuid = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: uuid,
       name: name,
       email: email,
       cpf: cpf
     }}
  end

  def build(_email, _name, _cpf) do
    {:error, "Invalid parameters 🍇"}
  end
end
