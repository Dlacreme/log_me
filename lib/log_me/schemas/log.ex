defmodule LogMe.Schemas.Log do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "logs" do
    field :content, :map
    field :environment, :string
    field :metadata, :map
    belongs_to :project, LogMe.Schemas.Projects

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [
      :project_id,
      :environment,
      :metadata,
      :content
    ])
    |> validate_required([:project_id, :type, :status_code, :content])
  end
end
