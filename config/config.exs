# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :omnixent_server, OmnixentServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/A8iGopQdp16UXe3pqYiH3CtOp5RUwlaQrC5rO7O7xmc5vr9oNGYVYY+lo1yte/U",
  render_errors: [view: OmnixentServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: OmnixentServer.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "keAIqwT8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
