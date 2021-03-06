defmodule WebManagerWeb.Router do
  use WebManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
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
  
  pipeline :admin do
    plug WebManager.Plugs.BasicAuth, Application.get_env(:web_manager, :basic)
  end

  scope "/api", WebManagerWeb do
    pipe_through :photos
    
    post "/photos", UploadController, :create
  end
  
  scope "/api", WebManagerWeb do
    pipe_through :api
    
    get "/troll", TrollController, :check
  end

  scope "/upload", WebManagerWeb do
    pipe_through :api

    post "/photo/:id", UploadController, :upload
  end

  scope "/", WebManagerWeb do
    pipe_through :browser
    live "/index", HomeLive

    get "/", PageController, :index
    get "/troll", TrollController, :set
    live "/slideshow", SlideshowLive
  end
  
  scope "/", WebManagerWeb do
    pipe_through [:browser, :admin]
    live "/photos", Photo
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebManagerWeb do
  #   pipe_through :api
  # end
end
