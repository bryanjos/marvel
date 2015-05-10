defmodule Marvel.API.Creators do
  alias Marvel.API.Utils

  @moduledoc """
  The Marvel Creators API
  """

  @endpoint "/creators"

  @doc """
  Fetches lists of creators
  """
  def list(params \\ %{}) do
    Utils.get(@endpoint, params)
  end

  @doc """
  Fetches a single creator by id
  """
  def get(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of comics filtered by a creator id
  """
  def comics(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/comics", params)
  end

  @doc """
  Fetches lists of events filtered by a creator id
  """
  def events(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/events", params)
  end

  @doc """
  Fetches lists of series filtered by a creator id
  """
  def series(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/series", params)
  end

  @doc """
  Fetches lists of stories filtered by a creator id
  """
  def stories(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/stories", params)
  end
  
end