defmodule LogMe.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  execute "CREATE EXTENSION IF NOT EXISTS citext", ""

  Repo.insert(%LogMe.Schemas.UserRoles{
    id: "admin",
    label: "Admin"
  })

  Repo.insert(%LogMe.Schemas.UserRoles{
    id: "user",
    label: "User"
  })

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :password, :string, size: 255, null: false
      add :role_id, references(:user_roles, type: :string), default: "user"
      add :username, :string, size: 255, null: true
      add :picture_url, :string, size: 2056, null: true
      add :validated_at, :utc_datetime

      timestamps()
    end

    create index(:users, [:id])
    create unique_index(:users, :email, name: :unique_index_user_email)
  end
end
