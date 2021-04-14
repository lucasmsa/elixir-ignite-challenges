defmodule GithubConsumerWeb.Router do
  use GithubConsumerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(GithubConsumerWeb.Auth.Pipeline)
  end

  scope "/api", GithubConsumerWeb do
    pipe_through([:api, :auth])
    get("github/:username", ClientController, :show)
    get("user/:id", UsersController, :show)
  end

  scope "/api", GithubConsumerWeb do
    pipe_through(:api)
    post("user/", UsersController, :create)
    post("user/signin", UsersController, :signin)
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
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: GithubConsumerWeb.Telemetry)
    end
  end
end
