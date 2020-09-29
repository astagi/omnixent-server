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

  def search_uuid(conn, params) do
    uuid = Map.get(params, "uuid")
    with {:true, results} <- make_search(uuid) do
      json conn, %{success: true, result: format_result(results)}
    else
      _ -> json conn, %{success: false, reason: "UUID not found"}
    end
  end

  defp make_search(uuid) when is_binary(uuid) do
    Omnixent.Mnesia.get_by_uuid(uuid)
  end

  defp make_search(p) do
    Omnixent.Services.search(
      p.term,
      p.service,
      p.country,
      p.lang
    )
  end

  # This will be removed with the next release.
  defp format_result(result) do
    first_res   = result |> hd
    term        = first_res.term
    date        = first_res.date
    service     = first_res.service
    country     = first_res.country
    language    = first_res.language
    search_uuid = first_res.uuid

    filtered_results = Enum.map(result, fn res ->
      %{
        id:     res.id,
        date:   res.date,
        term:   res.term,
        result: res.result
      }
    end)
    
    %{
      uuid:     search_uuid,
      term:     term,
      service:  service,
      country:  country,
      language: language,
      result:   filtered_results
    }
  end

end
