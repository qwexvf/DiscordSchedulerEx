defmodule DiscordScheduler.Repo do
  use Ecto.Repo,
    otp_app: :discord_scheduler,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
