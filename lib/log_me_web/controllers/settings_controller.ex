defmodule LogMeWeb.SettingsController do
  use LogMeWeb.BaseController

  def index(%{assigns: %{current_user: user}} = conn, _params) do
    conn |> render(:index, %{api_key: LogMeWeb.API.get_key()})
  end
end
