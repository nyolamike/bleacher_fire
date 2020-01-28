# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :bleacher_fire, BleacherFireWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o9YRVKxMrfJn0Ik+4U8qbRKScDE3OAdhz/HnJD0It4MF1c3/OcljGHR+i5m55lUH",
  render_errors: [view: BleacherFireWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BleacherFire.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
