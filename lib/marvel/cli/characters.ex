defmodule Marvel.CLI.Characters do
  @moduledoc false

  alias Marvel.CLI.Utils

  def list() do
    Marvel.API.Characters.list()
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def by_name(name) do
    Marvel.API.Characters.list(%{name: name})
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def by_id(id) do
    Marvel.API.Characters.get(id)
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def search(searchText) do
    Marvel.API.Characters.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def comics(id) do
    Marvel.API.Characters.comics(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def events(id) do
    Marvel.API.Characters.events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def series(id) do
    Marvel.API.Characters.series(id)
    |> Utils.process_results(&Utils.format_series_output/1)
  end

  def stories(id) do
    Marvel.API.Characters.stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end
end
