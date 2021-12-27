defmodule LogMeWeb.SettingsProjectLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Hello
    """
  end

  def mount(_params, session, socket) do
    IO.puts("LIVE SESSION > #{inspect(session)}")
    {:ok, socket}
  end
end
