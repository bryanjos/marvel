defmodule Marvel.CLI.Utils do
  def process_results(result, format_fn) do
    case result do
      {:ok, response } ->
        show_attribution(response)
        Enum.map(response["data"]["results"], &format_fn.(&1))
      {:error, body} ->
        IO.puts(body["message"])
    end
  end

  def show_attribution(data) do
    IO.puts(format_metadata("#{data["attributionText"]}"))

    offset = data["data"]["offset"]
    limit = data["data"]["limit"]
    total = data["data"]["total"]
    count = data["data"]["count"]

    IO.puts(format_metadata("offset: #{offset} limit: #{limit} total: #{total} count: #{count}"))
    print_end
  end

  def format_basic_character_output(character) do
    id = character["id"]
    name = character["name"]
    description = character["description"]

    creators_available = character["creators"]["available"]
    comics_available = character["comics"]["available"]
    series_available = character["series"]["available"]
    stories_available = character["stories"]["available"]
    events_available = character["events"]["available"]

    image = format_thumbnail(character["thumbnail"])

    format_row("Name", name) |> IO.puts
    format_row("ID", id) |> IO.puts
    format_row("Description", description) |> IO.puts
    format_row("Creators", creators_available) |> IO.puts
    format_row("Comics", comics_available) |> IO.puts
    format_row("Series", series_available) |> IO.puts
    format_row("Stories", stories_available) |> IO.puts
    format_row("Events", events_available) |> IO.puts
    format_row("Image", image) |> IO.puts
    print_end
  end

  def format_comic_output(comic) do
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

    image = format_thumbnail(comic["thumbnail"])

    format_row("Title", title) |> IO.puts
    format_row("ID", id) |> IO.puts
    format_row("Description", description) |> IO.puts
    format_row("ISBN", isbn) |> IO.puts
    format_row("Page Count", page_count) |> IO.puts
    format_row("Creators", creators) |> IO.puts
    format_row("Characters", characters) |> IO.puts
    format_row("Series", series) |> IO.puts
    format_row("Stories", stories) |> IO.puts
    format_row("Events", events) |> IO.puts
    format_row("Image", image) |> IO.puts
    print_end
  end

  def format_event_output(event) do
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

    image = format_thumbnail(event["thumbnail"])

    format_row("Title", title) |> IO.puts
    format_row("ID", id) |> IO.puts
    format_row("Description", description) |> IO.puts
    format_row("Start", start) |> IO.puts
    format_row("End", the_end) |> IO.puts
    format_row("Stories", stories) |> IO.puts
    format_row("Comics", comics) |> IO.puts
    format_row("Series", series) |> IO.puts
    format_row("Characters", characters) |> IO.puts
    format_row("Creators", creators) |> IO.puts
    format_row("Image", image) |> IO.puts
    print_end
  end

  def format_series_output(series) do
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

    image = format_thumbnail(series["thumbnail"])

    format_row("Title", title) |> IO.puts
    format_row("ID", id) |> IO.puts
    format_row("Description", description) |> IO.puts
    format_row("Start Year", start_year) |> IO.puts
    format_row("End Year", end_year) |> IO.puts
    format_row("Rating", rating) |> IO.puts
    format_row("Stories", stories) |> IO.puts
    format_row("Comics", comics) |> IO.puts
    format_row("Events", events) |> IO.puts
    format_row("Characters", characters) |> IO.puts
    format_row("Creators", creators) |> IO.puts
    format_row("Image", image) |> IO.puts
    print_end
  end

  def format_story_output(story) do
    id = story["id"]
    title = story["title"]
    description = story["description"]
    type = story["type"]

    comics = format_items(story["comics"]["items"])
    series = format_items(story["series"]["items"])
    events = format_items(story["events"]["items"])
    characters = format_items(story["characters"]["items"])
    creators = format_items(story["creators"]["items"])

    image = format_thumbnail(story["thumbnail"])

    format_row("Title", title) |> IO.puts
    format_row("ID", id) |> IO.puts
    format_row("Description", description) |> IO.puts
    format_row("Type", type) |> IO.puts
    format_row("Comics", comics) |> IO.puts
    format_row("Series", series) |> IO.puts
    format_row("Events", events) |> IO.puts
    format_row("Characters", characters) |> IO.puts
    format_row("Creators", creators) |> IO.puts
    format_row("Image", image) |> IO.puts
    print_end
  end

  defp print_end() do
    "" |> IO.puts
    "" |> IO.puts
  end

  defp format_row(key, value) do
    IO.ANSI.format([:red, "#{key}: ", :white, "#{value}"], true)
  end

  defp format_metadata(meta) do
    IO.ANSI.format([:yellow, "#{meta}"], true)
  end

  def format_items(items) do
    Enum.map(items, fn(x) -> 
          id = x["resourceURI"] |> String.split("/") |> List.last
          name = x["name"]

          "#{name} (#{id})"
        end) 
        |> Enum.join(", ")
  end

  def format_thumbnail(nil) do
    ""
  end

  def format_thumbnail(thumbnail) do
    thumbnail["path"] <> "." <> thumbnail["extension"]
  end
end