# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :preload_test,
  ecto_repos: [PreloadTest.Repo]

# Configures the endpoint
config :preload_test, PreloadTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S8gFzIesV43zoeI75kvxTV74WlY1jy+99/ahT1cMdvV8zI/OGfTWDbkc0Zby44nj",
  render_errors: [view: PreloadTestWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PreloadTest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
