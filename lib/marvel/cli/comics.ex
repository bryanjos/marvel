defmodule Marvel.CLI.Comics do
  @moduledoc false
  
  alias Marvel.CLI.Utils

  def list() do
    Marvel.API.Comics.list()
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def by_name(name) do
    Marvel.API.Comics.list(%{name: name})
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def by_id(id) do
    Marvel.API.Comics.get(id)
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def search(searchText) do
    Marvel.API.Comics.list(%{nameStartsWith: searchText})
    |> Utils.process_results(&Utils.format_comic_output/1)
  end

  def characters(id) do
    Marvel.API.Comics.characters(id)
    |> Utils.process_results(&Utils.format_character_output/1)
  end

  def events(id) do
    Marvel.API.Comics.events(id)
    |> Utils.process_results(&Utils.format_event_output/1)
  end

  def series(id) do
    Marvel.API.Comics.creators(id)
    |> Utils.process_results(&Utils.format_creators_output/1)
  end

  def stories(id) do
    Marvel.API.Comics.stories(id)
    |> Utils.process_results(&Utils.format_story_output/1)
  end
end