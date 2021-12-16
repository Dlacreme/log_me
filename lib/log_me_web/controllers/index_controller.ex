defmodule LogMeWeb.IndexController do
  use LogMeWeb.BaseController

  def index(%{assigns: %{current_user: user}} = conn, _params) when user != nil do
    conn |> render(:index)
  end

  def index(conn, _params) do
    conn |> redirect(to: Routes.auth_path(conn, :login))
  end
end
