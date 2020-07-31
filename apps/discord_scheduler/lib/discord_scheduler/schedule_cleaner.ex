defmodule DiscordScheduler.ScheduleCleaner do
  alias DiscordScheduler.Schedules

  def perform() do
    Schedules.clear()
  end
end
