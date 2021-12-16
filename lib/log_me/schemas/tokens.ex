defmodule LogMe.Schemas.Tokens do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tokens" do
    field :token, :string
    field :deprecated_at, :utc_datetime
    belongs_to :user, LogMe.Schemas.Users
    belongs_to :type, LogMe.Schemas.TokenTypes, type: :string

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(tokens, attrs) do
    tokens
    |> cast(attrs, [:token, :type_id, :user_id, :deprecated_at])
    |> validate_required([:token, :type_id, :user_id, :deprecated_at])
  end
end
