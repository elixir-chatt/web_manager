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
     signing_salt: System.get_env("live_view_salt") || "vEkTRMkKljqGtKn8OCD2UQLA/OY9sBVN"
  ],
  url: [host: "localhost"],
  secret_key_base: System.get_env("enter_secret_key"),
  render_errors: [view: WebManagerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WebManager.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures S3 storage on digital ocean using Spaces
config :ex_aws, :s3,
    access_key_id: System.get_env("access_key_id"),
    secret_access_key: System.get_env("secret_access_key"),
    scheme: "https://",
    host: System.get_env("s3_host"),
    region: "nyc3"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
