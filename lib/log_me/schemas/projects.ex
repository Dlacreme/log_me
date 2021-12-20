defmodule LogMe.Schemas.Projects do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :label, :string

    timestamps()
  end

  @doc false
  def changeset(projects, attrs) do
    projects
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
