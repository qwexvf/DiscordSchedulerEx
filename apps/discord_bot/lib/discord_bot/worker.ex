defmodule DiscordBot.Worker do
  alias Nostrum.Api

  alias DiscordScheduler.Schedules

  @spec perform(any) :: {:ok, %DiscordScheduler.Schedules.Schedule{}}
  def perform(payload) do
    schedule = Schedules.get_schedule!(payload)

    unless schedule.is_sent do
      {intVal, ""} = Integer.parse(Application.get_env(:discord_bot, :channel))

      if schedule.image do
        url = Schedules.get_image_url(schedule)
        path = Application.app_dir(:discord_scheduler_web, "priv/static/") <> url

        Api.create_message!(intVal, content: schedule.message, file: path)
      else
        Api.create_message!(intVal, schedule.message)
      end

      Schedules.update_schedule(schedule, %{is_sent: true})
    end
  end
end
