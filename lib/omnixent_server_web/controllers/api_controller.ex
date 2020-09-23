defmodule OmnixentServerWeb.ApiController do
  use OmnixentServerWeb, :controller

  def index(conn, _params) do
    json conn, %{success: true}
  end

  def availability(conn, _params) do
    json conn, %{success: true, result: Omnixent.Core.availability}
  end

  def search(conn, params) do
    with {:ok, params} <- get_search_params(params),
         result        <- make_search(params) do

      json conn, %{success: true, result: result}
    else
      {:error, reason} ->
        json conn, %{success: false, reason: reason}
    end
  end

  defp get_search_params(params) do
    term    = (params |> Map.get("term")) || ""
    service = (params |> Map.get("service") |> String.to_atom) || ""
    lang    = (params |> Map.get("lang")    |> String.to_atom) || :en
    country = (params |> Map.get("country") |> String.to_atom) || :us

    cond do
      term == ""    ->
        {:error, "'term' parameter is required"}
      service == "" ->
        {:error, "'service' parameter is required"}
      true ->
        {:ok,
          %{
            term:    term,
            service: service,
            lang:    lang,
            country: country
          }
        }
    end
  end

  defp make_search(p) do
    Omnixent.Services.search(
      p.term,
      p.service,
      p.country,
      p.lang
    )
  end

end
