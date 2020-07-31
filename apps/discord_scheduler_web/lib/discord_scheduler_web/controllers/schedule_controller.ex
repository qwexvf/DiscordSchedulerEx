defmodule DiscordSchedulerWeb.ScheduleController do
  use DiscordSchedulerWeb, :controller

  alias DiscordScheduler.Schedules
  alias DiscordScheduler.Schedules.Schedule

  action_fallback DiscordSchedulerWeb.FallbackController

  def index(conn, params) do
    pages =
      if params["orderBy"] == "asc" do
        Schedules.paginate_schedules(params, :asc)
      else
        Schedules.paginate_schedules(params, :desc)
      end

    render conn, "index.json", pages: pages
  end

  def create(conn, %{"schedule" => schedule_param, "image" => image_param}) do
    decode_schedule_params = Jason.decode!(schedule_param)
    decode_schedule_params = Map.put(decode_schedule_params, "image", image_param)

    with {:ok, schedule} <- Schedules.create_schedule(decode_schedule_params),
         {:ok, updated_schedule} <- Schedules.enqueue_schedule(schedule) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.schedule_path(conn, :show, updated_schedule))
      |> render("show.json", schedule: updated_schedule)
    end
  end

  def create(conn, %{"schedule" => schedule_param}) do
    decode_schedule_params = Jason.decode!(schedule_param)

    with {:ok, schedule} <- Schedules.create_schedule(decode_schedule_params),
         {:ok, updated_schedule} <- Schedules.enqueue_schedule(schedule) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.schedule_path(conn, :show, updated_schedule))
      |> render("show.json", schedule: updated_schedule)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)

    render(conn, "show.json", schedule: schedule)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params, "image" => image_param}) do
    schedule = Schedules.get_schedule!(id)

    decode_schedule_params = Jason.decode!(schedule_params)
    decode_schedule_params = Map.put(decode_schedule_params, "image", image_param)

    with {:ok, %Schedule{} = schedule} <- Schedules.update_schedule(schedule, decode_schedule_params) do
      render(conn, "show.json", schedule: schedule)
    end
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params, }) do
    schedule = Schedules.get_schedule!(id)
    decode_schedule_params = Jason.decode!(schedule_params)

    with {:ok, %Schedule{} = schedule} <- Schedules.update_schedule(schedule, decode_schedule_params) do
      render(conn, "show.json", schedule: schedule)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)

    with {:ok, %Schedule{}} <- Schedules.delete_schedule(schedule) do
      send_resp(conn, :no_content, "")
    end
  end

  def send(conn, %{"id" => id}) do
    with {:ok, schedule} <- Schedules.send_message(id) do
      render(conn, "show.json", schedule: schedule)
    end
  end

  def delete_schedule_from_list(conn, %{"schedules" => schedule_ids}) do
    with _schedules <- Schedules.delete_list_schedules(schedule_ids) do
      send_resp(conn, :no_content, "")
    end
  end
end
