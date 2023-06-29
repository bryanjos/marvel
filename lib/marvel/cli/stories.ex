defmodule Marvel.CLI.Stories do
  @moduledoc false

  alias Marvel.CLI.Utils

  def list() do
    Marvel.API.Stories.list()
    |> Utils.process_results(&Utils.format_story_output/1)
  end

  def by_name(name) do
    Marvel.API.Stories.list(%{name: name})
    |> Utils.process_results(&Utils.format_story_output/1)
  end

  def by_id(id) do
    Marvel.API.Stories.get(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end

  def search(searchText) do
    Marvel.API.Stories.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_story_output/1)
  end

  def comics(id) do
    Marvel.API.Stories.comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def characters(id) do
    Marvel.API.Stories.events(id)
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def creators(id) do
    Marvel.API.Stories.creators(id)
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def events(id) do
    Marvel.API.Stories.events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def series(id) do
    Marvel.API.Stories.series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end
end
