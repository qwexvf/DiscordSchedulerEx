defmodule DiscordScheduler.SchedulesTest do
  use DiscordScheduler.DataCase

  alias DiscordScheduler.Schedules

  describe "schedules" do
    alias DiscordScheduler.Schedules.Schdule

    @valid_attrs %{is_sent: true, job_id: "some job_id", message: "some message", reservation_date: "2010-04-17T14:00:00Z"}
    @update_attrs %{is_sent: false, job_id: "some updated job_id", message: "some updated message", reservation_date: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{is_sent: nil, job_id: nil, message: nil, reservation_date: nil}

    def schdule_fixture(attrs \\ %{}) do
      {:ok, schdule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedules.create_schdule()

      schdule
    end

    test "list_schedules/0 returns all schedules" do
      schdule = schdule_fixture()
      assert Schedules.list_schedules() == [schdule]
    end

    test "get_schdule!/1 returns the schdule with given id" do
      schdule = schdule_fixture()
      assert Schedules.get_schdule!(schdule.id) == schdule
    end

    test "create_schdule/1 with valid data creates a schdule" do
      assert {:ok, %Schdule{} = schdule} = Schedules.create_schdule(@valid_attrs)
      assert schdule.is_sent == true
      assert schdule.job_id == "some job_id"
      assert schdule.message == "some message"
      assert schdule.reservation_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_schdule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schdule(@invalid_attrs)
    end

    test "update_schdule/2 with valid data updates the schdule" do
      schdule = schdule_fixture()
      assert {:ok, %Schdule{} = schdule} = Schedules.update_schdule(schdule, @update_attrs)
      assert schdule.is_sent == false
      assert schdule.job_id == "some updated job_id"
      assert schdule.message == "some updated message"
      assert schdule.reservation_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_schdule/2 with invalid data returns error changeset" do
      schdule = schdule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schdule(schdule, @invalid_attrs)
      assert schdule == Schedules.get_schdule!(schdule.id)
    end

    test "delete_schdule/1 deletes the schdule" do
      schdule = schdule_fixture()
      assert {:ok, %Schdule{}} = Schedules.delete_schdule(schdule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schdule!(schdule.id) end
    end

    test "change_schdule/1 returns a schdule changeset" do
      schdule = schdule_fixture()
      assert %Ecto.Changeset{} = Schedules.change_schdule(schdule)
    end
  end

  describe "schedules" do
    alias DiscordScheduler.Schedules.Schedule

    @valid_attrs %{is_sent: true, job_id: "some job_id", message: "some message", reservation_date: "2010-04-17T14:00:00Z"}
    @update_attrs %{is_sent: false, job_id: "some updated job_id", message: "some updated message", reservation_date: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{is_sent: nil, job_id: nil, message: nil, reservation_date: nil}

    def schedule_fixture(attrs \\ %{}) do
      {:ok, schedule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedules.create_schedule()

      schedule
    end

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Schedules.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Schedules.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      assert {:ok, %Schedule{} = schedule} = Schedules.create_schedule(@valid_attrs)
      assert schedule.is_sent == true
      assert schedule.job_id == "some job_id"
      assert schedule.message == "some message"
      assert schedule.reservation_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{} = schedule} = Schedules.update_schedule(schedule, @update_attrs)
      assert schedule.is_sent == false
      assert schedule.job_id == "some updated job_id"
      assert schedule.message == "some updated message"
      assert schedule.reservation_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schedule(schedule, @invalid_attrs)
      assert schedule == Schedules.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Schedules.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Schedules.change_schedule(schedule)
    end
  end
end
