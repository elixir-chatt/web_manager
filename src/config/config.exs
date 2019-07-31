# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :web_manager,
  ecto_repos: [WebManager.Repo]

# Configures the endpoint
config :web_manager, WebManagerWeb.Endpoint,
  live_view: [
     signing_salt: "enterSaltHere"
  ],
  url: [host: "localhost"],
  secret_key_base: "enterSecretKey",
  render_errors: [view: WebManagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebManager.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "enterSaltHere"
  ]

# Configures S3 storage on digital ocean using Spaces
config :ex_aws, :s3,
  %{
    access_key_id: "configure key",
    secret_access_key: "configure key",
    scheme: "https://",
    host: %{"nyc3" => "nyc3.digitaloceanspaces.com"},
    region: "nyc3"
  }

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
