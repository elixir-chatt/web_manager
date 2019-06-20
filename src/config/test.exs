use Mix.Config

# Configure your database
config :web_manager, WebManager.Repo,
  username: "postgres",
  password: "postgres",
  database: "web_manager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
  #adapter: MssqlEcto,
  #database: "RafikiDB",
  #username: "MBOADEV",
  #password: "mySecurePa$$word",
  #hostname: "localhost",
  #instance_name: "JONSURFACE",
  #port: "1433"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_manager, WebManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
