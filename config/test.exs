import Config

# Print only warnings and errors during test
config :logger, level: :warning

# Marvel API configuration
config :marvel, :marvel_api,
  http_client: Marvel.HTTPClientMock,
  base_url: "https://gateway.marvel.com/v1/public"
