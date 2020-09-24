defmodule OmnixentServerWeb.Resolvers.Content do

  def list_availabilities(_parent, _args, _resolution) do
    {:ok, Omnixent.Core.availability}
  end

  def get_search(_parent, %{term: term, country: country, language: language, service: service}, _resolution) do

    result = Omnixent.Services.search(
      term,
      :"#{service}",
      :"#{country}",
      :"#{language}"
    )

    {:ok, result}
  end

end