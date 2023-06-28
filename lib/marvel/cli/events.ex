defmodule Marvel.CLI.Events do
  @moduledoc false

  alias Marvel.CLI.Utils

  def list() do
    Marvel.API.Events.list()
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def by_name(name) do
    Marvel.API.Events.list(%{name: name})
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def by_id(id) do
    Marvel.API.Events.get(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def search(searchText) do
    Marvel.API.Events.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_event_output/1)
  end



  def comics(id) do
    Marvel.API.Events.comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def characters(id) do
    Marvel.API.Events.events(id)
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def creators(id) do
    Marvel.API.Events.creators(id)
    |> Utils.process_results(&Utils.format_creator_output/1)
  end

  def series(id) do
    Marvel.API.Events.series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end

  def stories(id) do
    Marvel.API.Events.stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end
end
