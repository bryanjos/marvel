defmodule Marvel.API.Series do
  alias Marvel.API.Utils

  @moduledoc """
  The Marvel Series API
  """

  @endpoint "/series"

  @doc """
  Fetches lists of series
  """
  def list(params \\ %{}) do
    Utils.get(@endpoint, params)
  end

  @doc """
  Fetches a single comic series by id
  """
  def get(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of characters filtered by a series id
  """
  def characters(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/characters", params)
  end

  @doc """
  Fetches lists of comics filtered by a series id
  """
  def comics(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/comics", params)
  end

  @doc """
  Fetches lists of creators filtered by a series id
  """
  def creators(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/creators", params)
  end

  @doc """
  Fetches lists of events filtered by a series id
  """
  def events(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/events", params)
  end

  @doc """
  Fetches lists of stories filtered by a series id
  """
  def stories(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/stories", params)
  end
  
end