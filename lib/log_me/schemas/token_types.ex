defmodule LogMe.Schemas.TokenTypes do
  use Ecto.Schema

  @primary_key {:id, :string, autogenerate: false}
  @foreign_key_type :string
  schema "token_types" do
    field :label, :string
  end
end
