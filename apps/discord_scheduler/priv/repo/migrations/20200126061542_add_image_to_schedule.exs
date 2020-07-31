defmodule DiscordScheduler.Repo.Migrations.AddImageToSchedule do
  use Ecto.Migration

  def change do
    drop table(:testapis)

    alter table(:schedules) do
      add :image, :string
      add :uuid, :string
    end
  end
end
