defmodule Marvel.CLI.Characters do
  @moduledoc false
  
  alias Marvel.CLI.Utils

  def characters() do
    Marvel.API.Characters.list()
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def character_by_name(name) do
    Marvel.API.Characters.list(%{name: name})
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def character_by_id(id) do
    Marvel.API.Characters.get(id)
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def character_search(searchText) do
    Marvel.API.Characters.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def character_comics(id) do
    Marvel.API.Characters.comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def character_events(id) do
    Marvel.API.Characters.events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def character_series(id) do
    Marvel.API.Characters.series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end

  def character_stories(id) do
    Marvel.API.Characters.stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end
end