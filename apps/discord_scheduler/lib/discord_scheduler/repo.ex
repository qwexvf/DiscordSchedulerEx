defmodule DiscordScheduler.Repo do
  use Ecto.Repo,
    otp_app: :discord_scheduler,
    adapter: Ecto.Adapters.Postgres
end
