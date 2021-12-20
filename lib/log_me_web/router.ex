defmodule LogMeWeb.Router do
  use LogMeWeb, :router

  import LogMeWeb.AuthPlug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LogMeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LogMeWeb do
    pipe_through :browser

    get "/", IndexController, :index
    get "/login", AuthController, :login
    post "/login", AuthController, :login_post
  end

  scope "/settings", LogMeWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", SettingsController, :index
    post "/invite", SettingsController, :invite
    post "/remove-from-team", SettingsController, :remove_from_team
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LogMeWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
