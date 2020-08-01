use Mix.Config

config :discord_scheduler_web, DiscordSchedulerWeb.Endpoint,
  url: [scheme: "https", host: "secure-headland-93870.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :discord_scheduler, DiscordScheduler.Repo,
  ssl: true,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

config :exq,
  name: Exq,
  url: System.get_env("REDIS_URL"),
  namespace: "exq",
  concurrency: :infinite,
  queues: ["default"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 3,
  shutdown_timeout: 5000

config :discord_bot,
  channel: ""

config :nostrum,
  token: "", # The token of your bot as a string
  num_shards: :auto

config :logger, level: :info
