defmodule OmnixentServerWeb.ApiController do
  use OmnixentServerWeb, :controller

  def index(conn, _params) do
    json conn, %{success: true}
  end

  def search(conn, params) do
    with {:ok, params} <- get_search_params(params),
         result <- make_search(params) do

      json conn, %{success: true, result: result}
    else
      {:error, reason} ->
        json conn, %{success: false, reason: reason}
    end
  end

  defp get_search_params(params) do
    term    = Map.get(params, "term")    || ""
    service = Map.get(params, "service") || ""
    lang    = Map.get(params, "lang")    || "en"
    country = Map.get(params, "country") || "us"

    cond do
      term == ""    ->
        {:error, "'term' parameter is required"}
      service == "" -> 
        {:error, "'service' parameter is required"}
      true ->
        {:ok,
          %{
            term:    term,
            service: String.to_atom(service),
            lang:    String.to_atom(lang),
            country: String.to_atom(country)
          }
        }
    end
  end

  defp make_search(p) do
    Omnixent.Services.search(
      p.term,
      p.service,
      p.lang,
      p.country
    )
  end

end