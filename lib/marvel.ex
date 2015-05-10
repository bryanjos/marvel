defmodule Marvel do
  @moduledoc """
    API client and CLI for the [Marvel API Client](http://developer.marvel.com/)

    The API and CLI both looks for either a `marvel` config block with the following keys:

    * `public_key` - Your Marvel Public Key
    * `private_key` - Your Marvel Private Key


    or looks for the following environment variables


    * `MARVEL_PUBLIC_KEY` - Your Marvel Public Key
    * `MARVEL_PRIVATE_KEY` - Your Marvel Private Key


    Usage for CLI Client:

    ```
    usage: marvel <command> [options]

    commands:
      characters  Gets character data

    options:
    -s  --search  [searchText]  searches for characters that begin with the searchText
    -i  --id [id]               the id of the character
    -co --comics                the comics for the character
    -ev --events                the events for the character
    -se --series                the series for the character
    -st --stories               the stories for the character
    ```
  """
end
