defmodule Marvel.API do
  @moduledoc """
  API Client for the Marvel API
  """

  @base_url "http://gateway.marvel.com:80/v1/public"

  def character(id) do
    get("/characters/#{id}")
  end

  def character_comics(id) do
    get("/characters/#{id}/comics")
  end
  
  def characters(params \\ %{}) do
    get("/characters", params)
  end

  def characters_search(searchText) do
    characters(%{nameStartsWith: searchText})
  end

  def characters_name(name) do
    characters(%{name: name})
  end

  defp public_key do
    System.get_env("MARVEL_PUBLIC_KEY")
  end

  defp private_key do
    System.get_env("MARVEL_PRIVATE_KEY")
  end

  defp timestamp do
    round(Timex.Time.now(:secs))
  end

  defp get(url, params \\ %{}) do
    ts = timestamp
    apikey = public_key
    hash = :crypto.hash(:md5, "#{ts}#{private_key}#{apikey}") |> Base.encode16(case: :lower)

    params = Map.merge(params, %{ts: ts, apikey: apikey, hash: hash})
    params = URI.encode_query(params)


    case HTTPoison.get("#{@base_url}#{url}?#{params}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body) }
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} when status_code in 401..409 ->
        {:error, Poison.decode!(body) }
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{"message": reason} }
    end
  end

end