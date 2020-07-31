# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :discord_scheduler,
  ecto_repos: [DiscordScheduler.Repo]

config :discord_scheduler_web,
  ecto_repos: [DiscordScheduler.Repo],
  generators: [context_app: :discord_scheduler]

# Configures the endpoint
config :discord_scheduler_web, DiscordSchedulerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TU2S7I8DjVF7HRe0n7OjWesmwnWysqTurekMjkUnfoHK6OD28ZyzZ1bN8ZI0yURe",
  render_errors: [view: DiscordSchedulerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DiscordSchedulerWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :exq,
  name: Exq,
  host: "redis",
  port: 6379,
  password: "bot",
  namespace: "exq",
  concurrency: :infinite,
  queues: ["default"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  shutdown_timeout: 5000

config :arc,
  storage: Arc.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
