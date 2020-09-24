defmodule OmnixentServerWeb.Schema do
  use Absinthe.Schema
  import_types OmnixentServerWeb.Schema.ContentTypes
  alias OmnixentServerWeb.Resolvers

  query do
    
    @desc "Get all availabilities"
    field :availabilities, list_of(:availability) do
      resolve &Resolvers.Content.list_availabilities/3
    end

  end

end