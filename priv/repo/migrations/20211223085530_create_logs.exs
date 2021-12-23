defmodule LogMe.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :project_id, references(:projects, type: :binary_id), null: false
      add :environment, :string, null: true, default: nil
      add :metadata, :map, null: true, default: nil
      add :content, :map, null: false

      timestamps(updated_at: false)
    end
  end
end
