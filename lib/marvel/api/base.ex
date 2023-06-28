defmodule Marvel.API.Base do
  @moduledoc false

  @base_url "http://gateway.marvel.com/v1/public"

  defmacro __using__(opts) do
    quote do
      @doc """
      Fetches lists
      """
      @spec list(map) :: map
      def list(params \\ %{}) do
        Marvel.API.Base.get(unquote(opts[:entity]), params)
      end

      @doc """
      Fetches a single entity by id
      """
      @spec get(integer, map) :: map
      def get(id, params \\ %{}) do
        Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}", params)
      end

      if unquote(opts[:entity]) != "characters" && unquote(opts[:entity]) != "creators" do
        @doc """
        Fetches lists of characters filtered by id
        """
        @spec characters(integer, map) :: map
        def characters(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/characters", params)
        end
      end

      if unquote(opts[:entity]) != "comics" do
        @doc """
        Fetches lists of comics filtered by id
        """
        @spec comics(integer, map) :: map
        def comics(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/comics", params)
        end
      end

      if unquote(opts[:entity]) != "creators" && unquote(opts[:entity]) != "characters" do
        @doc """
        Fetches lists of creators filtered by id
        """
        @spec creators(integer, map) :: map
        def creators(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/creators", params)
        end
      end

      if unquote(opts[:entity]) != "events" do
        @doc """
        Fetches lists of events filtered by id
        """
        @spec events(integer, map) :: map
        def events(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/events", params)
        end
      end

      if unquote(opts[:entity]) != "series" && unquote(opts[:entity]) != "comics" do
        @doc """
        Fetches lists of series filtered by id
        """
        @spec series(integer, map) :: map
        def series(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/series", params)
        end
      end

      if unquote(opts[:entity]) != "stories" do
        @doc """
        Fetches lists of stories filtered by id
        """
        @spec stories(integer, map) :: map
        def stories(id, params \\ %{}) do
          Marvel.API.Base.get("#{unquote(opts[:entity])}/#{id}/stories", params)
        end
      end
    end
  end

  def get(endpoint, params) do
    config = default_config()
    base_url = Keyword.get(config, :base_url, @base_url)
    http_client = Keyword.get(config, :http_client)

    ts = timestamp()
    private_key = private_key()
    public_key = public_key()

    hash =
      :crypto.hash(:md5, "#{ts}#{private_key}#{public_key}")
      |> Base.encode16(case: :lower)

    params =
      Map.merge(params, %{ts: ts, apikey: public_key, hash: hash})
      |> URI.encode_query()

    case http_client.get("#{base_url}/#{endpoint}?#{params}") do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status_code: status_code, body: body}} when status_code in 401..409 ->
        {:error, Jason.decode!(body)}

      {:error, %{reason: reason}} ->
        {:error, %{message: reason}}
    end
  end

  defp public_key() do
    Application.get_env(:marvel, :public_key, System.get_env("MARVEL_PUBLIC_KEY"))
  end

  defp private_key() do
    Application.get_env(:marvel, :private_key, System.get_env("MARVEL_PRIVATE_KEY"))
  end

  defp timestamp() do
    Timex.to_unix(Timex.now())
  end

  defp default_config(), do: Application.get_env(:marvel, :marvel_api)
end
