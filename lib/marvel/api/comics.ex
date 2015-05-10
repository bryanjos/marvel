defmodule Marvel.API.Comics do
  alias Marvel.API

  @moduledoc """
  The Marvel Comics API
  """

  @endpoint "/comics"

  @doc """
  Fetches lists of comics
  """
  def list(params \\ %{}) do
    API.get(@endpoint, params)
  end

  @doc """
  Fetches a single comic by id
  """
  def get(id, params \\ %{}) do
    API.get("#{@endpoint}/#{id}", params)
  end

  @doc """
  Fetches lists of characters filtered by a comic id
  """
  def characters(id, params \\ %{}) do
    API.get("#{@endpoint}/#{id}/characters", params)
  end

  @doc """
  Fetches lists of creators filtered by a comic id
  """
  def creators(id, params \\ %{}) do
    API.get("#{@endpoint}/#{id}/creators", params)
  end

  @doc """
  Fetches lists of events filtered by a comic id
  """
  def events(id, params \\ %{}) do
    API.get("#{@endpoint}/#{id}/events", params)
  end

  @doc """
  Fetches lists of stories filtered by a comic id
  """
  def stories(id, params \\ %{}) do
    API.get("#{@endpoint}/#{id}/stories", params)
  end
  
end