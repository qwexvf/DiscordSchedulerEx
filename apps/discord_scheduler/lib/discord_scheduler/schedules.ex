defmodule DiscordScheduler.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  alias DiscordScheduler.Repo

  alias DiscordScheduler.Schedules.Schedule

  @doc """
  Returns the list of schedules.

  ## Examples

      iex> list_schedules()
      [%Schedule{}, ...]

  """
  def list_schedules do
    Repo.all(Schedule)
  end

  def paginate_schedules(params, :asc) do
    Schedule
    |> order_by(asc: :reservation_date)
    |> where([s], s.is_sent == ^params["is_sent"])
    |> DiscordScheduler.Repo.paginate(page: params["page_number"], page_size: 10)
  end

  def paginate_schedules(params, :desc) do
    Schedule
    |> order_by(desc: :reservation_date)
    |> where([s], s.is_sent == ^params["is_sent"])
    |> DiscordScheduler.Repo.paginate(page: params["page_number"], page_size: 10)
  end

  @doc """
  """
  def delete_list_schedules(ids) do
    ids
    |> get_schedule_list()
    |> Enum.each(fn schedule ->
      Exq.Api.remove_scheduled(Exq.Api, schedule.job_id)
    end)

    Schedule
    |> where([s], s.id in ^ids)
    |> Repo.delete_all()
  end

  @doc """
  Gets a single schedule.

  Raises `Ecto.NoResultsError` if the Schedule does not exist.

  ## Examples

      iex> get_schedule!(123)
      %Schedule{}

      iex> get_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schedule!(id) do
    Repo.get!(Schedule, id)
  end

  @spec get_image_url(DiscordScheduler.Schedules.Schedule.t()) :: String
  def get_image_url(%Schedule{} = schedule) do
    if schedule.image != nil do
      "/images/uploads/#{schedule.uuid}/#{schedule.uuid}_original_#{schedule.image.file_name}"
    end
  end

  @doc """
  Gets a single schedule.

  Raises `Ecto.NoResultsError` if the Schedule does not exist.

  ## Examples

      iex> get_schedule!(123)
      %Schedule{}

      iex> get_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schedule_list(ids) do
    Schedule
    |> where([s], s.id in ^ids)
    |> Repo.all()
  end

  @doc """
  Creates a schedule.

  ## Examples

      iex> create_schedule(%{field: value})
      {:ok, %Schedule{}}

      iex> create_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_schedule(attrs \\ %{}) do
    %Schedule{}
    |> Schedule.changeset(attrs)
    |> Repo.insert()
  end

  @spec enqueue_schedule(DiscordScheduler.Schedules.Schedule.t()) :: any
  def enqueue_schedule(schedule) do
    {:ok, jid} =
      Exq.enqueue_at(Exq, "default", schedule.reservation_date, DiscordBot.Worker, [schedule.id])

    update_schedule(schedule, %{job_id: jid})
  end

  @doc """
  Updates a schedule.

  ## Examples

      iex> update_schedule(schedule, %{field: new_value})
      {:ok, %Schedule{}}

      iex> update_schedule(schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schedule(%Schedule{} = schedule, attrs) do
    schedule
    |> Schedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Schedule.

  ## Examples

      iex> delete_schedule(schedule)
      {:ok, %Schedule{}}

      iex> delete_schedule(schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schedule(%Schedule{} = schedule) do
    Repo.delete(schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schedule changes.

  ## Examples

      iex> change_schedule(schedule)
      %Ecto.Changeset{source: %Schedule{}}

  """
  def change_schedule(%Schedule{} = schedule) do
    Schedule.changeset(schedule, %{})
  end

  def send_message(id) do
    schedule = get_schedule!(id)
    Exq.Api.remove_scheduled(Exq.Api, schedule.job_id)

    {:ok, nil} = Exq.Api.find_scheduled(Exq.Api, schedule.job_id)
    DiscordBot.Worker.perform(schedule.id)
  end

  def clear() do
    six_month_ago = Timex.shift(Timex.now(), months: -6)

    Schedule
    |> where([s], s.inserted_at < ^six_month_ago)
    |> Repo.delete_all()

    Exq.enqueue_in(Exq, "default", 86400, DiscordScheduler.ScheduleCleaner, [])
  end
end
