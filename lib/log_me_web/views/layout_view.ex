defmodule LogMeWeb.LayoutView do
  use LogMeWeb, :view
  alias LogMe.Schemas.Users

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def user_name(%Users{email: email, username: username}) do
    if username != nil && username != "", do: username, else: email
  end

  def icon(name), do: content_tag(:i, name, class: "material-icons")
end
