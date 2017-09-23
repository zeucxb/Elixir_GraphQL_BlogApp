defmodule BlogAppWeb.Router do
  use BlogAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/contacts", ContactController, except: [:new, :edit]
  end

  scope "/api", BlogAppWeb do
    pipe_through :api
  end

  forward "/graph", Absinthe.Plug,
    schema: BlogApp.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: BlogApp.Schema
end
