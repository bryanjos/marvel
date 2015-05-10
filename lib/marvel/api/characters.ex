defmodule Marvel.API.Characters do
  alias Marvel.API.Utils

  @moduledoc """
  The Marvel Characters API
  """

  @endpoint "/characters"

  @doc """
  Fetches lists of characters
  """
  def list(params \\ %{}) do
    Utils.get(@endpoint, params)
  end

  @doc """
  Fetches a single character by id
  """
  def get(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of comics filtered by a character id
  """
  def comics(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/comics", params)
  end

  @doc """
  Fetches lists of events filtered by a character id
  """
  def events(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/events", params)
  end

  @doc """
  Fetches lists of series filtered by a character id
  """
  def series(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/series", params)
  end

  @doc """
  Fetches lists of stories filtered by a character id
  """
  def stories(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/stories", params)
  end
  
end