defmodule Marvel do
  @moduledoc """
    API client and CLI for the [Marvel API Client](http://developer.marvel.com/)

    The API and CLI both looks for either a `marvel` config block with the following keys:

    * `public_key` - Your Marvel Public Key
    * `private_key` - Your Marvel Private Key

    <br/>
    or looks for the following environment variables

    <br/>
    * `MARVEL_PUBLIC_KEY` - Your Marvel Public Key
    * `MARVEL_PRIVATE_KEY` - Your Marvel Private Key

    <br/>

    Usage for CLI Client:

    ```
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
    ```
  """
end
