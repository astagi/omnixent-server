defmodule OmnixentServerWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :search do
    field :id,     :id
    field :date,   :integer
    field :term,   :string
    field :result, list_of(:string)
  end

  object :availability do
    field :countries, list_of(:string)
    field :languages, list_of(:string)
    field :services,  list_of(:string)
  end
end