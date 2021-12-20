defmodule LogMeWeb.SettingsController do
  use LogMeWeb.BaseController
  alias LogMe.Schemas.Users
  alias LogMe.Repo

  def index(%{assigns: %{current_user: %{id: id}}} = conn, _params) do
    conn |> render(:index, api: api(), team: team(id), project: project())
  end

  def invite(%{assigns: %{current_user: %{id: id}}} = conn, %{"users" => user_params}) do
    case %Users{}
         |> Users.changeset_register(Map.put_new(user_params, "role_id", "user"))
         |> Repo.insert() do
      {:ok, _user} ->
        conn
        |> put_flash(:success, "User has been invited")
        |> redirect(to: Routes.settings_path(conn, :index))

      {:error, err} ->
        conn
        |> put_flash(:error, "Failed to invite user")
        |> redirect(to: Routes.settings_path(conn, :index))
    end
  end

  def remove_from_team(conn, %{"id" => id}) do
    LogMe.Account.User.get(id)
    |> Repo.delete()

    conn
    |> put_flash(:success, "Removed from the team")
    |> redirect(to: Routes.settings_path(conn, :index))
  end

  defp api(),
    do: %{key: LogMeWeb.API.get_key()}

  defp team(current_user_id),
    do: %{
      users: LogMe.Account.User.list() |> Enum.filter(fn x -> x.id != current_user_id end),
      changeset: %Users{} |> Users.changeset_register(%{})
    }

  defp project(),
    do: %{
      project: Repo.all(LogMe.Schemas.Projects)
    }
end
