defmodule Marvel.API.Events do
  alias Marvel.API.Utils

  @moduledoc """
  The Marvel Events API
  """

  @endpoint "/events"

  @doc """
  Fetches lists of events
  """
  def list(params \\ %{}) do
    Utils.get(@endpoint, params)
  end

  @doc """
  Fetches a single event by id
  """
  def get(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of characters filtered by an event id
  """
  def characters(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/characters", params)
  end

  @doc """
  Fetches lists of comics filtered by an event id
  """
  def comics(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/comics", params)
  end

  @doc """
  Fetches lists of creators filtered by an event id
  """
  def creators(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/creators", params)
  end

  @doc """
  Fetches lists of series filtered by an event id
  """
  def series(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/series", params)
  end

  @doc """
  Fetches lists of stories filtered by an event id
  """
  def stories(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/stories", params)
  end
  
end