defmodule BinbaseBackendWeb.Router do
  use BinbaseBackendWeb, :router

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

#  scope "/", BinbaseBackendWeb do
#    pipe_through :browser # Use the default browser stack

#    get "/", PageController, :index
#  end

  # Other scopes may use custom stacks.
   scope "/api", BinbaseBackendWeb do
     pipe_through :api

     get "/users/:id", UserController, :show
   end
end
