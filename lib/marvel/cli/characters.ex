defmodule Marvel.CLI.Characters do

  def find_character(name) do
    Marvel.API.characters_name(name)
    |> process_character_results()
  end

  def find_character_by_id(id) do
    Marvel.API.character(id)
    |> process_character_results()
  end

  def find_character_comics(id) do
    Marvel.API.character_comics(id)
    |> process_comic_results()
  end

  def search_for_character(searchText) do
    Marvel.API.characters_search(searchText)
    |> process_character_results()
  end

  def list_characters() do
    Marvel.API.characters()
    |> process_character_results()
  end

  defp process_character_results(result) do
    case result do
      {:ok, characters } ->
        Marvel.CLI.show_attribution(characters)
        Enum.map(characters["data"]["results"], &format_basic_character_output(&1))
      {:error, body} ->
        IO.puts(body["message"])
    end
  end

  defp process_comic_results(result) do
    case result do
      {:ok, comics } ->
        Marvel.CLI.show_attribution(comics)
        Enum.map(comics["data"]["results"], &format_comic_output(&1))
      {:error, body} ->
        IO.puts(body["message"])
    end
  end

  defp format_basic_character_output(character) do
    id = character["id"]
    name = character["name"]
    description = character["description"]
    comics_available = character["comics"]["available"]
    series_available = character["series"]["available"]
    stories_available = character["stories"]["available"]
    events_available = character["events"]["available"]
    image = character["thumbnail"]["path"] <> "." <> character["thumbnail"]["extension"]

    IO.puts("""
      Name: #{name}
      ID: #{id}
      Description: #{description}
      Comics: #{comics_available}
      Series: #{series_available}
      Stories: #{stories_available}
      Events: #{events_available}
      Image: #{image}
      ----------------------------
    """)
  end

  defp format_comic_output(comic) do
    id = comic["id"]
    title = comic["title"]
    description = comic["description"]
    isbn = comic["isbn"]
    page_count = comic["pageCount"]
    series = comic["series"]["name"]
    creators = format_items(comic["creators"]["items"])
    characters = format_items(comic["characters"]["items"])
    stories = format_items(comic["stories"]["items"])
    events = format_items(comic["events"]["items"])

    image = comic["thumbnail"]["path"] <> "." <> comic["thumbnail"]["extension"]

    IO.puts("""
      Title: #{title}
      ID: #{id}
      Description: #{description}
      ISBN: #{isbn}
      Page Count: #{page_count}
      Creators: #{creators}
      Characters #{characters}
      Series: #{series}
      Stories: #{stories}
      Events: #{events}
      Image: #{image}
      ----------------------------
    """)
  end

  defp format_event_output(event) do
    id = event["id"]
    title = event["title"]
    description = event["description"]
    start = event["start"]
    the_end = event["end"]

    stories = format_items(event["stories"]["items"])
    comics = format_items(event["comics"]["items"])
    series = format_items(event["series"]["items"])
    characters = format_items(event["characters"]["items"])
    creators = format_items(event["creators"]["items"])

    image = event["thumbnail"]["path"] <> "." <> event["thumbnail"]["extension"]

    IO.puts("""
      Title: #{title}
      ID: #{id}
      Description: #{description}
      Start: #{start}
      End: #{the_end}
      Stories: #{stories}
      Comics: #{comics}
      Series: #{series}
      Characters #{characters}
      Creators: #{creators}
      Image: #{image}
      ----------------------------
    """)
  end

  defp format_series_output(series) do
    id = series["id"]
    title = series["title"]
    description = series["description"]
    start_year = series["start_year"]
    end_year = series["end_year"]
    rating = series["rating"]

    stories = format_items(series["stories"]["items"])
    comics = format_items(series["comics"]["items"])
    events = format_items(series["events"]["items"])
    characters = format_items(series["characters"]["items"])
    creators = format_items(series["creators"]["items"])

    image = series["thumbnail"]["path"] <> "." <> series["thumbnail"]["extension"]

    IO.puts("""
      Title: #{title}
      ID: #{id}
      Description: #{description}
      Start Year: #{start_year}
      End Year: #{end_year}
      Events: #{events}
      Stories: #{stories}
      Comics: #{comics}
      Characters #{characters}
      Creators: #{creators}
      Image: #{image}
      ----------------------------
    """)
  end

  defp format_items(items) do
    Enum.map(items, fn(x) -> 
          id = x["resourceURI"] |> String.split("/") |> List.last
          name = x["name"]

          "#{name} (#{id})"
        end) 
        |> Enum.join(",")
  end
end