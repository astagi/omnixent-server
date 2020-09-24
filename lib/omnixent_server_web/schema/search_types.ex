defmodule OmnixentServerWeb.Schema.SearchTypes do
  use Absinthe.Schema.Notation

  @desc "A single search result"
  object :search do
    field :term,     :string
    field :country,  :string
    field :language, :string
    field :service,  :string
    field :result,   list_of(:search_result)
  end

  object :search_result do
    field :id,       :integer
    field :date,     :integer
    field :term,     :string
    field :result,  list_of(:string)
  end

end