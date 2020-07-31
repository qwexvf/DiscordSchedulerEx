defmodule DiscordSchedulerWeb.ScheduleView do
  use DiscordSchedulerWeb, :view
  alias DiscordSchedulerWeb.ScheduleView
  import DiscordScheduler.Schedules, only: [get_image_url: 1]

  def render("index.json", %{schedules: schedules}) do
    %{data: render_many(schedules, ScheduleView, "schedule.json")}
  end

  def render("index.json", %{pages: pages}) do
    %{
      data: render_many(pages.entries, ScheduleView, "schedule.json"),
      params:  %{
        page_number: pages.page_number,
        page_size: pages.page_size,
        total_pages: pages.total_pages,
        total_entries: pages.total_entries
      }
    }
  end

  def render("show.json", %{schedule: schedule}) do
    %{data: render_one(schedule, ScheduleView, "schedule.json")}
  end

  def render("schedule.json", %{schedule: schedule}) do
    %{id: schedule.id,
      message: schedule.message,
      job_id: schedule.job_id,
      reservation_date: schedule.reservation_date,
      is_sent: schedule.is_sent,
      image: get_image_url(schedule)
    }
  end
end
