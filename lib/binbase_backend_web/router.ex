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

    plug Guardian.Plug.Pipeline, module: BinbaseBackend.Auth.Guardian,
                             error_handler: BinbaseBackend.Auth.ErrorHandler

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug BinbaseBackendWeb.Plug.Context    
  end

  pipeline :api_stateless do
    plug :accepts, ["json"]
  end

#  scope "/", BinbaseBackendWeb do
#    pipe_through :browser # Use the default browser stack

#    get "/", PageController, :index
#  end

  # Other scopes may use custom stacks.

   scope "/api2", BinbaseBackendWeb do
     pipe_through :api_stateless

     get "/check_email", UserController, :check
   end
     
   scope "/api", BinbaseBackendWeb do
     pipe_through :api

     get "/users/:id", UserController, :show
     post "/register", UserController, :join
     
     post "/add", OrdersController, :join
   end
end
