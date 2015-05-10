defmodule Marvel.API do
  @moduledoc """
  API Client for the [Marvel API](http://developer.marvel.com/docs) 
  """

  @base_url "http://gateway.marvel.com:80/v1/public"

  def characters(params \\ %{}) do
    get("/characters", params)
  end

  def character(id, params \\ %{}) do
    get("/characters/#{id}", params)
  end

  def character_comics(id, params \\ %{}) do
    get("/characters/#{id}/comics", params)
  end

  def character_events(id, params \\ %{}) do
    get("/characters/#{id}/events", params)
  end

  def character_series(id, params \\ %{}) do
    get("/characters/#{id}/series", params)
  end

  def character_stories(id, params \\ %{}) do
    get("/characters/#{id}/stories", params)
  end

  def comics(params \\ %{}) do
    get("/comics", params)
  end

  def comic(id, params \\ %{}) do
    get("/comics/#{id}", params)
  end

  def comic_characters(id, params \\ %{}) do
    get("/comics/#{id}/characters", params)
  end

  def comic_creators(id, params \\ %{}) do
    get("/comics/#{id}/creators", params)
  end

  def comic_events(id, params \\ %{}) do
    get("/comics/#{id}/events", params)
  end

  def comic_stories(id, params \\ %{}) do
    get("/comics/#{id}/stories", params)
  end

  def creators(params \\ %{}) do
    get("/creators", params)
  end

  def creator(id, params \\ %{}) do
    get("/creators/#{id}", params)
  end

  def creator_comics(id, params \\ %{}) do
    get("/creators/#{id}/comics", params)
  end

  def creator_events(id, params \\ %{}) do
    get("/creators/#{id}/events", params)
  end

  def creator_series(id, params \\ %{}) do
    get("/creators/#{id}/series", params)
  end

  def creator_stories(id, params \\ %{}) do
    get("/creators/#{id}/stories", params)
  end


  def events(params \\ %{}) do
    get("/events", params)
  end

  def event(id, params \\ %{}) do
    get("/events/#{id}", params)
  end

  def event_characters(id, params \\ %{}) do
    get("/events/#{id}/characters", params)
  end

  def event_comics(id, params \\ %{}) do
    get("/events/#{id}/comics", params)
  end

  def event_creators(id, params \\ %{}) do
    get("/events/#{id}/creators", params)
  end

  def event_series(id, params \\ %{}) do
    get("/events/#{id}/series", params)
  end

  def event_stories(id, params \\ %{}) do
    get("/events/#{id}/stories", params)
  end


  def series(id \\ nil, params \\ %{}) do
    if !id do
      get("/series", params)
    else
      get("/series/#{id}", params)
    end
  end

  def series_characters(id, params \\ %{}) do
    get("/series/#{id}/characters", params)
  end

  def series_comics(id, params \\ %{}) do
    get("/series/#{id}/comics", params)
  end

  def series_creators(id, params \\ %{}) do
    get("/series/#{id}/creators", params)
  end

  def series_events(id, params \\ %{}) do
    get("/series/#{id}/events", params)
  end

  def series_stories(id, params \\ %{}) do
    get("/series/#{id}/stories", params)
  end


  def stories(params \\ %{}) do
    get("/stories", params)
  end

  def story(id, params \\ %{}) do
    get("/stories/#{id}", params)
  end

  def story_characters(id, params \\ %{}) do
    get("/stories/#{id}/characters", params)
  end

  def story_comics(id, params \\ %{}) do
    get("/stories/#{id}/comics", params)
  end

  def story_creators(id, params \\ %{}) do
    get("/stories/#{id}/creators", params)
  end

  def story_events(id, params \\ %{}) do
    get("/stories/#{id}/events", params)
  end

  def story_series(id, params \\ %{}) do
    get("/stories/#{id}/series", params)
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

  defp get(url, params) do
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