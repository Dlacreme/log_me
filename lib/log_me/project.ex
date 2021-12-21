defmodule LogMe.Project do
  @moduledoc """
  Helpers to maintain projects
  """
  alias LogMe.Schemas.Projects
  alias LogMe.Repo

  import Ecto.Query, only: [from: 2]

  def get(id),
    do: Repo.one(from p in Projects, where: p.id == ^id)
end
