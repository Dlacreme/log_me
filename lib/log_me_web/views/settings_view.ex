defmodule LogMeWeb.SettingsView do
  use LogMeWeb, :view

  def icon(name), do: content_tag(:i, name, class: "material-icons")
end
