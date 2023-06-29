defmodule Marvel.API.Test do
  use ExUnit.Case, async: false

  import Mox

  alias Marvel.API.{
    Characters,
    Comics,
    Creators,
    Events,
    Series,
    Stories
  }

  describe "Marvel API module" do
    test "list/0 fetches a list of entities" do
      characters_list_resp = mock_successful_response("characters_list")
      comics_list_resp = mock_successful_response("comics_list")
      creators_list_resp = mock_successful_response("creators_list")
      events_list_resp = mock_successful_response("events_list")
      series_list_resp = mock_successful_response("series_list")
      stories_list_resp = mock_successful_response("stories_list")

      assert {:ok, characters_list_resp} == Characters.list()
      assert {:ok, comics_list_resp} == Comics.list()
      assert {:ok, creators_list_resp} == Creators.list()
      assert {:ok, events_list_resp} == Events.list()
      assert {:ok, series_list_resp} == Series.list()
      assert {:ok, stories_list_resp} == Stories.list()
    end

    test "get/1 fetches a single entity by id" do
      characters_get_resp = mock_successful_response("characters_get")
      comics_get_resp = mock_successful_response("comics_get")
      creators_get_resp = mock_successful_response("creators_get")
      events_get_resp = mock_successful_response("events_get")
      series_get_resp = mock_successful_response("series_get")
      stories_get_resp = mock_successful_response("stories_get")

      assert {:ok, characters_get_resp} == Characters.get(1011334)
      assert {:ok, comics_get_resp} == Comics.get(82967)
      assert {:ok, creators_get_resp} == Creators.get(13970)
      assert {:ok, events_get_resp} == Events.get(116)
      assert {:ok, series_get_resp} == Series.get(31445)
      assert {:ok, stories_get_resp} == Stories.get(7)
    end

    test "get/1 returns 404 for unknown id" do
      resp = mock_not_found_response()

      assert {:error, resp} == Characters.get(1)
      assert {:error, resp} == Comics.get(2)
      assert {:error, resp} == Creators.get(3)
      assert {:error, resp} == Events.get(4)
      assert {:error, resp} == Series.get(5)
      assert {:error, resp} == Stories.get(6)
    end

    test "characters/2 fetches a list of characters" do
      stories_characters_resp = mock_successful_response("stories_characters")
      comics_characters_resp = mock_successful_response("comics_characters")
      events_characters_resp = mock_successful_response("events_characters")
      series_characters_resp = mock_successful_response("series_characters")

      assert {:ok, stories_characters_resp} == Stories.characters(1011334)
      assert {:ok, comics_characters_resp} == Comics.characters(82967)
      assert {:ok, events_characters_resp} == Events.characters(116)
      assert {:ok, series_characters_resp} == Series.characters(31445)
    end

    test "comics/2 fetches a list of comics" do
      characters_comics_resp = mock_successful_response("characters_comics")
      creators_comics_resp = mock_successful_response("creators_comics")
      events_comics_resp = mock_successful_response("events_comics")
      series_comics_resp = mock_successful_response("series_comics")
      stories_comics_resp = mock_successful_response("stories_comics")

      assert {:ok, characters_comics_resp} == Characters.comics(1011334)
      assert {:ok, creators_comics_resp} == Creators.comics(13970)
      assert {:ok, events_comics_resp} == Events.comics(116)
      assert {:ok, series_comics_resp} == Series.comics(31445)
      assert {:ok, stories_comics_resp} == Stories.comics(7)
    end

    test "creators/2 fetches a list of creators" do
      stories_creators_resp = mock_successful_response("stories_creators")
      events_creators_resp = mock_successful_response("events_creators")
      series_creators_resp = mock_successful_response("series_creators")
      comics_creators_resp = mock_successful_response("comics_creators")

      assert {:ok, stories_creators_resp} == Comics.creators(82967)
      assert {:ok, events_creators_resp} == Events.creators(116)
      assert {:ok, series_creators_resp} == Series.creators(31445)
      assert {:ok, comics_creators_resp} == Stories.creators(7)
    end

    test "events/2 fetches a list of events" do
      characters_events_resp = mock_successful_response("characters_events")
      comics_events_resp = mock_successful_response("comics_events")
      creators_events_resp = mock_successful_response("creators_events")
      series_events_resp = mock_successful_response("series_events")
      stories_events_resp = mock_successful_response("stories_events")

      assert {:ok, characters_events_resp} == Characters.get(1011334)
      assert {:ok, comics_events_resp} == Comics.get(82967)
      assert {:ok, creators_events_resp} == Creators.get(13970)
      assert {:ok, series_events_resp} == Series.get(31445)
      assert {:ok, stories_events_resp} == Stories.get(7)
    end

    test "series/2 fetches a list of series" do
      characters_series_resp = mock_successful_response("characters_series")
      creators_series_resp = mock_successful_response("creators_series")
      events_series_resp = mock_successful_response("events_series")
      stories_series_resp = mock_successful_response("stories_series")

      assert {:ok, characters_series_resp} == Characters.series(1011334)
      assert {:ok, creators_series_resp} == Creators.series(13970)
      assert {:ok, events_series_resp} == Events.series(116)
      assert {:ok, stories_series_resp} == Stories.series(7)
    end

    test "stories/2 fetches a list of stories" do
      characters_stories_resp = mock_successful_response("characters_stories")
      comics_stories_resp = mock_successful_response("comics_stories")
      creators_stories_resp = mock_successful_response("creators_stories")
      events_stories_resp = mock_successful_response("events_stories")
      series_stories_resp = mock_successful_response("series_stories")

      assert {:ok, characters_stories_resp} == Characters.stories(1011334)
      assert {:ok, comics_stories_resp} == Comics.stories(82967)
      assert {:ok, creators_stories_resp} == Creators.stories(13970)
      assert {:ok, events_stories_resp} == Events.stories(116)
      assert {:ok, series_stories_resp} == Series.stories(31445)
    end
  end

  @http_client Marvel.HTTPClientMock

  defp mock_successful_response(type) do
    {resp, _} = Code.eval_file( "test/support/fixtures/#{type}.exs")

    expect(
      @http_client,
      :get,
      fn _url ->
        {:ok, %HTTPoison.Response{body: resp |> Jason.encode!(), status_code: 200}}
      end
    )

    resp
  end

  defp mock_not_found_response() do
    resp = %{"code" => 404, "status" => "We couldn't find that <object>"}

    expect(
      @http_client,
      :get,
      6,
      fn _url ->
        {:ok, %HTTPoison.Response{status_code: 404, body: resp |> Jason.encode!()}}
      end
    )

    resp
  end
end
