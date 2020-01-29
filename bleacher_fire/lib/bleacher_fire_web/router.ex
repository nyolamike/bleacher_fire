defmodule BleacherFireWeb.Router do
  use BleacherFireWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BleacherFireWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/reactions", ReactionsController, :index
    
  end

  # Other scopes may use custom stacks.
  scope "/api", BleacherFireWeb do
    pipe_through :api

    get "/reaction_count/:content_id", ReactionCountController, :index
  end
end
