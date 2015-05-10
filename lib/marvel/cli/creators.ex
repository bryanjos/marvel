defmodule Marvel.CLI.Creators do
  @moduledoc false
  
  alias Marvel.CLI.Utils

  def list() do
    Marvel.API.Creators.list()
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def by_name(name) do
    Marvel.API.Creators.list(%{name: name})
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def by_id(id) do
    Marvel.API.Creators.get(id)
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def search(searchText) do
    Marvel.API.Creators.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def comics(id) do
    Marvel.API.Creators.comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def events(id) do
    Marvel.API.Creators.events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def series(id) do
    Marvel.API.Creators.series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end

  def stories(id) do
    Marvel.API.Creators.stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end
end