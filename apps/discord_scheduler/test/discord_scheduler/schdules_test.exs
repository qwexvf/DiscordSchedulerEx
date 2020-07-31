defmodule DiscordScheduler.SchdulesTest do
  use DiscordScheduler.DataCase

  alias DiscordScheduler.Schdules

  describe "schdules" do
    alias DiscordScheduler.Schdules.Schdule

    @valid_attrs %{is_sent: true, job_id: "some job_id", message: "some message", reservation_date: "2010-04-17T14:00:00Z"}
    @update_attrs %{is_sent: false, job_id: "some updated job_id", message: "some updated message", reservation_date: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{is_sent: nil, job_id: nil, message: nil, reservation_date: nil}

    def schdule_fixture(attrs \\ %{}) do
      {:ok, schdule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schdules.create_schdule()

      schdule
    end

    test "list_schdules/0 returns all schdules" do
      schdule = schdule_fixture()
      assert Schdules.list_schdules() == [schdule]
    end

    test "get_schdule!/1 returns the schdule with given id" do
      schdule = schdule_fixture()
      assert Schdules.get_schdule!(schdule.id) == schdule
    end

    test "create_schdule/1 with valid data creates a schdule" do
      assert {:ok, %Schdule{} = schdule} = Schdules.create_schdule(@valid_attrs)
      assert schdule.is_sent == true
      assert schdule.job_id == "some job_id"
      assert schdule.message == "some message"
      assert schdule.reservation_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_schdule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schdules.create_schdule(@invalid_attrs)
    end

    test "update_schdule/2 with valid data updates the schdule" do
      schdule = schdule_fixture()
      assert {:ok, %Schdule{} = schdule} = Schdules.update_schdule(schdule, @update_attrs)
      assert schdule.is_sent == false
      assert schdule.job_id == "some updated job_id"
      assert schdule.message == "some updated message"
      assert schdule.reservation_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_schdule/2 with invalid data returns error changeset" do
      schdule = schdule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schdules.update_schdule(schdule, @invalid_attrs)
      assert schdule == Schdules.get_schdule!(schdule.id)
    end

    test "delete_schdule/1 deletes the schdule" do
      schdule = schdule_fixture()
      assert {:ok, %Schdule{}} = Schdules.delete_schdule(schdule)
      assert_raise Ecto.NoResultsError, fn -> Schdules.get_schdule!(schdule.id) end
    end

    test "change_schdule/1 returns a schdule changeset" do
      schdule = schdule_fixture()
      assert %Ecto.Changeset{} = Schdules.change_schdule(schdule)
    end
  end
end
