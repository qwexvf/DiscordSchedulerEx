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
  secret_key_base: "oskXX7KYsZovY0P7Y3EcmH9Cqr/hIGEnBqdrtu31Psr5k75eezEbKRvfdr7+gLYA",
  render_errors: [view: DiscordSchedulerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DiscordScheduler.PubSub,
  live_view: [signing_salt: "+F1SgtC0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
