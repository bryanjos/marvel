defmodule Marvel.CLI.Utils do
  @moduledoc false

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
    print_metadata("#{data["attributionText"]}")

    offset = data["data"]["offset"]
    limit = data["data"]["limit"]
    total = data["data"]["total"]
    count = data["data"]["count"]

    print_metadata("offset: #{offset} limit: #{limit} total: #{total} count: #{count}")
    print_end()
  end

  def format_character_output(character) do
    id = character["id"]
    name = character["name"]
    description = character["description"]
    comics_available = character["comics"]["available"]
    series_available = character["series"]["available"]
    stories_available = character["stories"]["available"]
    events_available = character["events"]["available"]

    image = format_thumbnail(character["thumbnail"])

    print_row("Name", name)
    print_row("ID", id)
    print_row("Description", description)
    print_row("Comics", comics_available)
    print_row("Series", series_available)
    print_row("Stories", stories_available)
    print_row("Events", events_available)
    print_row("Image", image)
    print_end()
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

    print_row("Title", title)
    print_row("ID", id)
    print_row("Description", description)
    print_row("ISBN", isbn)
    print_row("Page Count", page_count)
    print_row("Creators", creators)
    print_row("Characters", characters)
    print_row("Series", series)
    print_row("Stories", stories)
    print_row("Events", events)
    print_row("Image", image)
    print_end()
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

    print_row("Title", title)
    print_row("ID", id)
    print_row("Description", description)
    print_row("Start", start)
    print_row("End", the_end)
    print_row("Stories", stories)
    print_row("Comics", comics)
    print_row("Series", series)
    print_row("Characters", characters)
    print_row("Creators", creators)
    print_row("Image", image)
    print_end()
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

    print_row("Title", title)
    print_row("ID", id)
    print_row("Description", description)
    print_row("Start Year", start_year)
    print_row("End Year", end_year)
    print_row("Rating", rating)
    print_row("Stories", stories)
    print_row("Comics", comics)
    print_row("Events", events)
    print_row("Characters", characters)
    print_row("Creators", creators)
    print_row("Image", image)
    print_end()
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

    print_row("Title", title)
    print_row("ID", id)
    print_row("Description", description)
    print_row("Type", type)
    print_row("Comics", comics)
    print_row("Series", series)
    print_row("Events", events)
    print_row("Characters", characters)
    print_row("Creators", creators)
    print_row("Image", image)
    print_end()
  end

  def format_creator_output(creator) do
    id = creator["id"]
    name = creator["fullName"]

    comics = format_items(creator["comics"]["items"])
    series = format_items(creator["series"]["items"])
    events = format_items(creator["events"]["items"])
    stories = format_items(creator["stories"]["items"])

    image = format_thumbnail(creator["thumbnail"])

    print_row("Name", name)
    print_row("ID", id)
    print_row("Comics", comics)
    print_row("Series", series)
    print_row("Events", events)
    print_row("Stories", stories)
    print_row("Image", image)
    print_end()
  end

  defp print_end() do
    "" |> IO.puts
    "" |> IO.puts
  end

  defp print_row(key, value) do
    IO.puts(IO.ANSI.format([:red, "#{key}: ", :white, "#{value}"], true))
  end

  defp print_metadata(meta) do
    IO.puts(IO.ANSI.format([:yellow, "#{meta}"], true))
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
