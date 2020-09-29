defmodule OmnixentServerWeb.Router do
  use OmnixentServerWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/api", OmnixentServerWeb do
    pipe_through :api

    get "/",                ApiController, :index
    get "/v1/availability", ApiController, :availability
    get "/v1/search",       ApiController, :search
    get "/v1/search/:uuid", ApiController, :search_uuid
    
  end

  scope "/graphql" do
    forward "/ui", Absinthe.Plug.GraphiQL,
    schema: OmnixentServerWeb.Schema
    
    forward "/", Absinthe.Plug,
    schema: OmnixentServerWeb.Schema
  end

end
