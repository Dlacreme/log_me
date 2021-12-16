defmodule LogMe.Schemas.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string
    field :picture_url, :string
    field :username, :string
    field :validated_at, :utc_datetime
    belongs_to :role, LogMe.Schemas.UserRoles, type: :string, primary_key: "role_id"

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:email, :password, :role_id, :username, :picture_url, :validated_at])
    |> validate_required([:email, :password, :role_id])
    |> validate_email()
    |> validate_password(attrs)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "invalid email")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, PB.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> put_change(:password, Bcrypt.hash_pwd_salt(password))
    else
      changeset
    end
  end
end
