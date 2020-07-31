defmodule DiscordScheduler.Schedules.Schedule do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  schema "schedules" do
    field :is_sent, :boolean, default: false
    field :job_id, :string
    field :message, :string
    field :reservation_date, :utc_datetime
    field :image, DiscordScheduler.Image.Type
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:message, :job_id, :reservation_date, :is_sent])
    |> create_uuid()
    |> validate_required([:message, :reservation_date])
    |> cast_attachments(attrs, [:image])
  end

  defp create_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, UUID.uuid4())
      _ ->
        changeset
    end
  end

end
