defmodule PentoWeb.Router do
  use PentoWeb, :router

  import PentoWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PentoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admins_only do
    plug :admin_basic_auth
  end

  scope "/", PentoWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PentoWeb do
  #   pipe_through :api
  # end

  # Enables a password protected LiveDashboard
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:browser, :admins_only]
    live_dashboard "/dashboard", metrics: PentoWeb.Telemetry
  end

  defp admin_basic_auth(conn, _opts) do
    username = System.fetch_env!("PENTO_ADMIN_AUTH_USERNAME")
    password = System.fetch_env!("PENTO_ADMIN_AUTH_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
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

  ## Authentication routes

  scope "/", PentoWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", PentoWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :default, on_mount: PentoWeb.UserAuthLive do
      live "/guess", WrongLive

      live "/faqs", FAQLive.Index, :index
      live "/faqs/new", FAQLive.Index, :new
      live "/faqs/:id/edit", FAQLive.Index, :edit
      live "/faqs/:id", FAQLive.Show, :show
      live "/faqs/:id/show/edit", FAQLive.Show, :edit

      live "/products", ProductLive.Index, :index
      live "/products/new", ProductLive.Index, :new
      live "/products/:id/edit", ProductLive.Index, :edit
      live "/products/:id", ProductLive.Show, :show
      live "/products/:id/show/edit", ProductLive.Show, :edit
    end

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", PentoWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
