defmodule DiscordScheduler.TestApis.TestApi do
  use Ecto.Schema
  import Ecto.Changeset

  schema "testapis" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(test_api, attrs) do
    test_api
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
