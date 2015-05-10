defmodule Marvel.CLI.Characters do
  @moduledoc false
  
  alias Marvel.CLI.Utils

  def characters() do
    Marvel.API.characters()
    |> Utils.process_results(&Utils.format_basic_character_output/1)
  end

  def character_by_name(name) do
    Marvel.API.characters(%{name: name})
    |> Utils.process_results(&Utils.format_basic_character_output/1)
  end

  def character_by_id(id) do
    Marvel.API.character(id)
    |> Utils.process_results(&Utils.format_basic_character_output/1)
  end

  def character_comics(id) do
    Marvel.API.character_comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def character_events(id) do
    Marvel.API.character_events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def character_series(id) do
    Marvel.API.character_series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end

  def character_stories(id) do
    Marvel.API.character_stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end

  def character_search(searchText) do
    Marvel.API.characters(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_basic_character_output/1)
  end
end