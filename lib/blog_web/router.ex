defmodule BlogWeb.Router do
  use BlogWeb, :router

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

  scope "/", BlogWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
  end


  # Other scopes may use custom stacks.
   scope "/api/v1", BlogWeb do
     pipe_through :api

     post "/sign_up", UserController, :create
     post "/sign_in", UserController, :sign_in
    end

  end
