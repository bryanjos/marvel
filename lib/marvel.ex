defmodule Marvel do
  @moduledoc """
    Marvel
    ======

    API client and CLI for the [Marvel API Client](http://developer.marvel.com/)

    The API and CLI both look for the following environment variables

    * `MARVEL_PUBLIC_KEY` - Your Marvel Public Key
    * `MARVEL_PRIVATE_KEY` - Your Marvel Private Key


    Usage for CLI Client:

    ```
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
    ```
  """
end
