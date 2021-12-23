defmodule LogMe.Repo.Migrations.AddFormatToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :log_format, :map,
        nil: false,
        default: %{
          level: "string",
          code: "integer",
          datetime: "datetime",
          message: "string"
        }
    end
  end
end
