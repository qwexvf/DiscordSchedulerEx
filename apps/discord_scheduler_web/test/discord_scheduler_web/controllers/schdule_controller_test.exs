defmodule DiscordSchedulerWeb.SchduleControllerTest do
  use DiscordSchedulerWeb.ConnCase

  alias DiscordScheduler.Schedules
  alias DiscordScheduler.Schedules.Schdule

  @create_attrs %{
    is_sent: true,
    job_id: "some job_id",
    message: "some message",
    reservation_date: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    is_sent: false,
    job_id: "some updated job_id",
    message: "some updated message",
    reservation_date: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{is_sent: nil, job_id: nil, message: nil, reservation_date: nil}

  def fixture(:schdule) do
    {:ok, schdule} = Schedules.create_schdule(@create_attrs)
    schdule
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all schedules", %{conn: conn} do
      conn = get(conn, Routes.schdule_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create schdule" do
    test "renders schdule when data is valid", %{conn: conn} do
      conn = post(conn, Routes.schdule_path(conn, :create), schdule: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.schdule_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_sent" => true,
               "job_id" => "some job_id",
               "message" => "some message",
               "reservation_date" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.schdule_path(conn, :create), schdule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update schdule" do
    setup [:create_schdule]

    test "renders schdule when data is valid", %{conn: conn, schdule: %Schdule{id: id} = schdule} do
      conn = put(conn, Routes.schdule_path(conn, :update, schdule), schdule: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.schdule_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_sent" => false,
               "job_id" => "some updated job_id",
               "message" => "some updated message",
               "reservation_date" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, schdule: schdule} do
      conn = put(conn, Routes.schdule_path(conn, :update, schdule), schdule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete schdule" do
    setup [:create_schdule]

    test "deletes chosen schdule", %{conn: conn, schdule: schdule} do
      conn = delete(conn, Routes.schdule_path(conn, :delete, schdule))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.schdule_path(conn, :show, schdule))
      end
    end
  end

  defp create_schdule(_) do
    schdule = fixture(:schdule)
    {:ok, schdule: schdule}
  end
end
