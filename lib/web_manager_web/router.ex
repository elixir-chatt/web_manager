defmodule WebManagerWeb.Router do
  use WebManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json", "multipart"]
  end
  
  pipeline :photos do
    plug :accepts, ["jpg"]
    plug WebManager.Plugs.LoadJpg
  end

  scope "/api", WebManagerWeb do
    pipe_through :photos

    post "/photos", UploadController, :create
  end

  scope "/upload", WebManagerWeb do
    pipe_through :api

    post "/photo/:id", UploadController, :upload
  end

  scope "/", WebManagerWeb do
    pipe_through :browser
    live "/index", HomeLive

    get "/", PageController, :index
    live "/slideshow", SlideshowLive
    live "/photos", Photo
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebManagerWeb do
  #   pipe_through :api
  # end
end
