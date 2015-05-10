defmodule Marvel.API.Stories do
  alias Marvel.API.Utils

  @moduledoc """
  The Marvel Stories API
  """

  @endpoint "/stories"

  @doc """
  Fetches lists of stories
  """
  def list(params \\ %{}) do
    Utils.get(@endpoint, params)
  end

  @doc """
  Fetches a single comic story by id
  """
  def get(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of characters filtered by a story id
  """
  def characters(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/characters", params)
  end

  @doc """
  Fetches lists of comics filtered by a story id
  """
  def comics(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/comics", params)
  end

  @doc """
  Fetches lists of creators filtered by a story id
  """
  def creators(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/creators", params)
  end

  @doc """
  Fetches lists of events filtered by a story id
  """
  def events(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/events", params)
  end

  @doc """
  Fetches lists of series filtered by a story id
  """
  def series(id, params \\ %{}) do
    Utils.get("#{@endpoint}/#{id}/series", params)
  end
  
end