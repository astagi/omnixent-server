defmodule OmnixentServerWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  @desc "All the availabilities"
  object :availabilities do
    field :countries, list_of(:string)
    field :languages, list_of(:string)
    field :services,  list_of(:string)
  end
end