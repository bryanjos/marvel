defmodule Marvel.CLI do
  @moduledoc false

  @characters_command "characters"
  @creators_command "creators"
  @comics_command "comics"
  @events_command "events"
  @series_command "series"
  @stories_command "stories"

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(args) do
    switches = [ 
      id: :integer, name: :binary, search: :binary, 
      comics: :boolean, events: :boolean, series: :boolean, 
      stories: :boolean, characters: :boolean, creators: :boolean 
    ]

    aliases = [ 
      i: :id, n: :name, s: :search, 
      co: :comics, ev: :events, se: :series, 
      st: :stories, ch: :characters, cr: :creators 
    ]
    
    parse = OptionParser.parse(args, switches: switches, aliases: aliases)

    case parse do
      { [id: _] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, comics: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, events: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, series: true] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [id: _, stories: true] = opts ,[@characters_command] , _ } -> { :characters, opts }
      { [search: _] = opts , [@characters_command] , _ } -> { :characters, opts }
      { [name: _] = opts , [@characters_command] , _ } -> { :characters, opts }
      { _ , [@characters_command] , _ } -> { :characters }

      { [id: _] = opts , [@comics_command] , _ } -> { :comics, opts }
      { [id: _, characters: true] = opts , [@comics_command] , _ } -> { :comics, opts }
      { [id: _, events: true] = opts , [@comics_command] , _ } -> { :comics, opts }
      { [id: _, creators: true] = opts , [@comics_command] , _ } -> { :comics, opts }
      { [id: _, stories: true] = opts ,[@comics_command] , _ } -> { :comics, opts }
      { [search: _] = opts , [@comics_command] , _ } -> { :comics, opts }
      { [name: _] = opts , [@comics_command] , _ } -> { :comics, opts }
      { _ , [@comics_command] , _ } -> { :comics }

      { [id: _] = opts , [@creators_command] , _ } -> { :creators, opts }
      { [id: _, comics: true] = opts , [@creators_command] , _ } -> { :creators, opts }
      { [id: _, events: true] = opts , [@creators_command] , _ } -> { :creators, opts }
      { [id: _, series: true] = opts , [@creators_command] , _ } -> { :creators, opts }
      { [id: _, stories: true] = opts ,[@creators_command] , _ } -> { :creators, opts }
      { [search: _] = opts , [@creators_command] , _ } -> { :creators, opts }
      { [name: _] = opts , [@creators_command] , _ } -> { :creators, opts }
      { _ , [@creators_command] , _ } -> { :creators }

      { [id: _] = opts , [@events_command] , _ } -> { :events, opts }
      { [id: _, characters: true] = opts , [@events_command] , _ } -> { :events, opts }
      { [id: _, comics: true] = opts , [@events_command] , _ } -> { :events, opts }
      { [id: _, creators: true] = opts , [@events_command] , _ } -> { :events, opts }
      { [id: _, series: true] = opts , [@events_command] , _ } -> { :events, opts }
      { [id: _, stories: true] = opts ,[@events_command] , _ } -> { :events, opts }
      { [search: _] = opts , [@events_command] , _ } -> { :events, opts }
      { [name: _] = opts , [@events_command] , _ } -> { :events, opts }
      { _ , [@events_command] , _ } -> { :events }

      { [id: _] = opts , [@series_command] , _ } -> { :series, opts }
      { [id: _, characters: true] = opts , [@series_command] , _ } -> { :series, opts }
      { [id: _, comics: true] = opts , [@series_command] , _ } -> { :series, opts }
      { [id: _, creators: true] = opts , [@series_command] , _ } -> { :series, opts }
      { [id: _, events: true] = opts , [@series_command] , _ } -> { :series, opts }
      { [id: _, stories: true] = opts ,[@series_command] , _ } -> { :series, opts }
      { [search: _] = opts , [@series_command] , _ } -> { :series, opts }
      { [name: _] = opts , [@series_command] , _ } -> { :series, opts }
      { _ , [@series_command] , _ } -> { :series }

      { [id: _] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [id: _, characters: true] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [id: _, comics: true] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [id: _, creators: true] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [id: _, events: true] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [id: _, series: true] = opts ,[@stories_command] , _ } -> { :stories, opts }
      { [search: _] = opts , [@stories_command] , _ } -> { :stories, opts }
      { [name: _] = opts , [@stories_command] , _ } -> { :stories, opts }
      { _ , [@stories_command] , _ } -> { :stories }


      _ -> :help
    end
  end

  def process({ :characters }) do
    Marvel.CLI.Characters.list()
  end

  def process({:characters, [name: name] }) do
    Marvel.CLI.Characters.by_name(name)
  end

  def process({:characters, [id: id] }) do
    Marvel.CLI.Characters.by_id(id)
  end

  def process({:characters, [id: id, comics: true] }) do
    Marvel.CLI.Characters.comics(id)
  end

  def process({:characters, [id: id, events: true] }) do
    Marvel.CLI.Characters.events(id)
  end

  def process({:characters, [id: id, series: true] }) do
    Marvel.CLI.Characters.series(id)
  end

  def process({:characters, [id: id, stories: true] }) do
    Marvel.CLI.Characters.stories(id)
  end

  def process({:characters, [search: searchText] }) do
    Marvel.CLI.Characters.search(searchText)
  end


  def process({ :comics }) do
    Marvel.CLI.Comics.list()
  end

  def process({:comics, [name: name] }) do
    Marvel.CLI.Comics.by_name(name)
  end

  def process({:comics, [id: id] }) do
    Marvel.CLI.Comics.by_id(id)
  end

  def process({:comics, [id: id, characters: true] }) do
    Marvel.CLI.Comics.characters(id)
  end

  def process({:comics, [id: id, events: true] }) do
    Marvel.CLI.Comics.events(id)
  end

  def process({:comics, [id: id, creators: true] }) do
    Marvel.CLI.Comics.creators(id)
  end

  def process({:comics, [id: id, stories: true] }) do
    Marvel.CLI.Comics.stories(id)
  end

  def process({:comics, [search: searchText] }) do
    Marvel.CLI.Comics.search(searchText)
  end


  def process({ :creators }) do
    Marvel.CLI.Creators.list()
  end

  def process({:creators, [name: name] }) do
    Marvel.CLI.Creators.by_name(name)
  end

  def process({:creators, [id: id] }) do
    Marvel.CLI.Creators.by_id(id)
  end

  def process({:creators, [id: id, series: true] }) do
    Marvel.CLI.Creators.series(id)
  end

  def process({:creators, [id: id, events: true] }) do
    Marvel.CLI.Creators.events(id)
  end

  def process({:creators, [id: id, comics: true] }) do
    Marvel.CLI.Creators.comics(id)
  end

  def process({:creators, [id: id, stories: true] }) do
    Marvel.CLI.Creators.stories(id)
  end

  def process({:creators, [search: searchText] }) do
    Marvel.CLI.Creators.search(searchText)
  end


  def process({ :events }) do
    Marvel.CLI.Events.list()
  end

  def process({:events, [name: name] }) do
    Marvel.CLI.Events.by_name(name)
  end

  def process({:events, [id: id] }) do
    Marvel.CLI.Events.by_id(id)
  end

  def process({:events, [id: id, series: true] }) do
    Marvel.CLI.Events.series(id)
  end

  def process({:events, [id: id, characters: true] }) do
    Marvel.CLI.Events.characters(id)
  end

  def process({:events, [id: id, creators: true] }) do
    Marvel.CLI.Events.creators(id)
  end

  def process({:events, [id: id, comics: true] }) do
    Marvel.CLI.Events.comics(id)
  end

  def process({:events, [id: id, stories: true] }) do
    Marvel.CLI.Events.stories(id)
  end

  def process({:events, [search: searchText] }) do
    Marvel.CLI.Events.search(searchText)
  end


  def process({ :series }) do
    Marvel.CLI.Series.list()
  end

  def process({:series, [name: name] }) do
    Marvel.CLI.Series.by_name(name)
  end

  def process({:series, [id: id] }) do
    Marvel.CLI.Series.by_id(id)
  end

  def process({:series, [id: id, events: true] }) do
    Marvel.CLI.Series.events(id)
  end

  def process({:series, [id: id, characters: true] }) do
    Marvel.CLI.Series.characters(id)
  end

  def process({:series, [id: id, creators: true] }) do
    Marvel.CLI.Series.creators(id)
  end

  def process({:series, [id: id, comics: true] }) do
    Marvel.CLI.Series.comics(id)
  end

  def process({:series, [id: id, stories: true] }) do
    Marvel.CLI.Series.stories(id)
  end

  def process({:series, [search: searchText] }) do
    Marvel.CLI.Series.search(searchText)
  end


  def process({ :stories }) do
    Marvel.CLI.Stories.list()
  end

  def process({:stories, [name: name] }) do
    Marvel.CLI.Stories.by_name(name)
  end

  def process({:stories, [id: id] }) do
    Marvel.CLI.Stories.by_id(id)
  end

  def process({:stories, [id: id, events: true] }) do
    Marvel.CLI.Stories.events(id)
  end

  def process({:stories, [id: id, characters: true] }) do
    Marvel.CLI.Stories.characters(id)
  end

  def process({:stories, [id: id, creators: true] }) do
    Marvel.CLI.Stories.creators(id)
  end

  def process({:stories, [id: id, comics: true] }) do
    Marvel.CLI.Stories.comics(id)
  end

  def process({:stories, [id: id, series: true] }) do
    Marvel.CLI.Stories.series(id)
  end

  def process({:stories, [search: searchText] }) do
    Marvel.CLI.Stories.search(searchText)
  end

  def process(:help) do
    IO.write """
      usage: marvel <command> [options]

      commands:
        characters    Gets character data.
        comics        Gets comic data.
        creators      Gets creator data.
        events        Gets event data.
        series        Gets series data.
        stories       Gets story data.

      "entity" in the options below correspond to the commands above.
      You cannot the option if it has the same name as the command

      invalid ex: marvel characters --characters

      options:
        -s  --search  [searchText]  searches for entities that begin with the searchText
        -i  --id [id]               the id of the entity
        -co --comics                the comics for the entity
        -ev --events                the events for the entity
        -se --series                the series for the entity (does not work for comics)
        -st --stories               the stories for the entity
        -ch --characters            the characters for the entity (does not work for creators)
        -ch --creators              the creators for the entity (does not work for characters)
    """
  end
end