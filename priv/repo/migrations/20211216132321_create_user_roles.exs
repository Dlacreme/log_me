defmodule LogMe.Repo.Migrations.CreateUserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles, primary_key: false) do
      add :id, :string, primary_key: true, length: 255
      add :label, :string, length: 255
    end
  end
end
