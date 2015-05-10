defmodule Marvel.CLI do
  @moduledoc false

  @characters_command "characters"

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(args) do
    switches = [ 
      id: :integer, search: :binary, comics: :boolean, 
      events: :boolean, series: :boolean, stories: :boolean 
    ]

    aliases = [ s: :search ]
    
    parse = OptionParser.parse(args, switches: switches, aliases: aliases)

    case parse do
      { _ , [@characters_command, name] , _ } -> { :characters, [name: name] }
      { [id: _] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, comics: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, events: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, series: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, stories: true] = opts ,[@characters_command] , _ } -> { :characters, opts }
      { [search: _] = opts , [@characters_command] , _ } -> { :characters, opts }
      { _ , [@characters_command] , _ } -> { :characters }


      _ -> :help
    end
  end
  def process({ :characters }) do
    Marvel.CLI.Characters.list_characters()
  end

  def process({:characters, [name: name] }) do
    Marvel.CLI.Characters.character_by_name(name)
  end

  def process({:characters, [id: id] }) do
    Marvel.CLI.Characters.character_by_id(id)
  end

  def process({:characters, [id: id, comics: true] }) do
    Marvel.CLI.Characters.character_comics(id)
  end

  def process({:characters, [id: id, events: true] }) do
    Marvel.CLI.Characters.character_events(id)
  end

  def process({:characters, [id: id, series: true] }) do
    Marvel.CLI.Characters.character_series(id)
  end

  def process({:characters, [id: id, stories: true] }) do
    Marvel.CLI.Characters.character_stories(id)
  end

  def process({:characters, [search: searchText] }) do
    Marvel.CLI.Characters.character_search(searchText)
  end

  def process(:help) do
    IO.write """
      usage: marvel <command> [options]

      commands:
        characters  Gets character data

      options:
      -s  --search  [searchText]  searches for characters that begin with the searchText
      --id [id]                   the id of the character
      --comics                    the comics for the character
      --events                    the events for the character
      --series                    the series for the character
      --stories                   the stories for the character
    """
  end
end