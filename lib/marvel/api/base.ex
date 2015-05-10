defmodule Marvel.API.Base do
  alias Marvel.API.Utils
  

  defmacro __using__(opts) do
    quote do
      @doc """
      Fetches lists
      """
      def list(params \\ %{}) do
        Utils.get(unquote(opts[:endpoint]), params)
      end

      @doc """
      Fetches a single entity by id
      """
      def get(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}", params)
      end

      @doc """
      Fetches lists of characters filtered by a entity id
      """
      def characters(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/characters", params)
      end

      @doc """
      Fetches lists of comics filtered by a entity id
      """
      def comics(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/comics", params)
      end

      @doc """
      Fetches lists of creators filtered by a entity id
      """
      def creators(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/creators", params)
      end

      @doc """
      Fetches lists of events filtered by a entity id
      """
      def events(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/events", params)
      end

      @doc """
      Fetches lists of series filtered by a entity id
      """
      def series(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/series", params)
      end

      @doc """
      Fetches lists of stories filtered by a entity id
      """
      def stories(id, params \\ %{}) do
        Utils.get("#{unquote(opts[:endpoint])}/#{id}/stories", params)
      end
    end
  end
end