use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :preload_test, PreloadTestWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :preload_test, PreloadTest.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "preload_test_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
