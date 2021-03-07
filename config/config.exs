# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :contai, Contai.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :contai,
  ecto_repos: [Contai.Repo]

# Configures the endpoint
config :contai, ContaiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TOTaGUML4QANHE2FNJ7RVusSZvEjOjg4yPHLxwpnGjpY1fyXy+mQRXjjS4H0mZka",
  render_errors: [view: ContaiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Contai.PubSub,
  live_view: [signing_salt: "dAHyQSmr"]

config :contai, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ContaiWeb.Router,
      endpoint: ContaiWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
