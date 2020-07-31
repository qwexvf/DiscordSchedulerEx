defmodule DiscordScheduler.Repo.Migrations.CreateTestapis do
  use Ecto.Migration

  def change do
    create table(:testapis) do
      add :title, :string

      timestamps()
    end

  end
end
