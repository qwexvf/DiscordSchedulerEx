defmodule DiscordScheduler.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :message, :text
      add :job_id, :string
      add :reservation_date, :utc_datetime
      add :is_sent, :boolean, default: false, null: false

      timestamps()
    end

  end
end
