defmodule OmnixentServerWeb.Schema do
  use Absinthe.Schema
  import_types OmnixentServerWeb.Schema.SearchTypes
  import_types OmnixentServerWeb.Schema.ContentTypes
  alias OmnixentServerWeb.Resolvers

  query do
    
    @desc "Get all availabilities"
    field :availabilities, list_of(:availabilities) do
      resolve &Resolvers.Content.list_availabilities/3
    end

    @desc "Get a specific term"
    field :search,   :search do
      arg :term,     non_null(:string)
      arg :service,  non_null(:string)
      arg :country,  :string
      arg :language, :string
      resolve &Resolvers.Content.get_search/3
    end

    @desc "Get a single search result"
    field :search_result, :search_result do
      arg :id,     :id
      arg :date,   :integer
      arg :term,   :string
      arg :result, list_of(:string)
    end

  end

end