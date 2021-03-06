defmodule GitExplorerWeb.Router do
  use GitExplorerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug GitExplorerWeb.Auth.Pipeline
    plug GitExplorerWeb.Plugs.RefreshToken
  end

  scope "/api", GitExplorerWeb do
    pipe_through [:api, :auth]

    get "/users/:user/repos", RepositoriesController, :index
  end

  scope "/api", GitExplorerWeb do
    pipe_through :api

    post "/sessions", SessionsController, :create
    post "/users", UsersController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GitExplorerWeb.Telemetry
    end
  end
end
