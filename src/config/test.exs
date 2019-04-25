use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_manager, WebManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :web_manager, WebManager.Repo,
  username: "postgres",
  password: "postgres",
  database: "web_manager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
