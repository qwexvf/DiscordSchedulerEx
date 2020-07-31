defmodule DiscordSchedulerWeb.SchduleControllerTest do
  use DiscordSchedulerWeb.ConnCase

  alias DiscordScheduler.Schdules

  @create_attrs %{is_sent: true, job_id: "some job_id", message: "some message", reservation_date: "2010-04-17T14:00:00Z"}
  @update_attrs %{is_sent: false, job_id: "some updated job_id", message: "some updated message", reservation_date: "2011-05-18T15:01:01Z"}
  @invalid_attrs %{is_sent: nil, job_id: nil, message: nil, reservation_date: nil}

  def fixture(:schdule) do
    {:ok, schdule} = Schdules.create_schdule(@create_attrs)
    schdule
  end

  describe "index" do
    test "lists all schdules", %{conn: conn} do
      conn = get(conn, Routes.schdule_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Schdules"
    end
  end

  describe "new schdule" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.schdule_path(conn, :new))
      assert html_response(conn, 200) =~ "New Schdule"
    end
  end

  describe "create schdule" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.schdule_path(conn, :create), schdule: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.schdule_path(conn, :show, id)

      conn = get(conn, Routes.schdule_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Schdule"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.schdule_path(conn, :create), schdule: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Schdule"
    end
  end

  describe "edit schdule" do
    setup [:create_schdule]

    test "renders form for editing chosen schdule", %{conn: conn, schdule: schdule} do
      conn = get(conn, Routes.schdule_path(conn, :edit, schdule))
      assert html_response(conn, 200) =~ "Edit Schdule"
    end
  end

  describe "update schdule" do
    setup [:create_schdule]

    test "redirects when data is valid", %{conn: conn, schdule: schdule} do
      conn = put(conn, Routes.schdule_path(conn, :update, schdule), schdule: @update_attrs)
      assert redirected_to(conn) == Routes.schdule_path(conn, :show, schdule)

      conn = get(conn, Routes.schdule_path(conn, :show, schdule))
      assert html_response(conn, 200) =~ "some updated job_id"
    end

    test "renders errors when data is invalid", %{conn: conn, schdule: schdule} do
      conn = put(conn, Routes.schdule_path(conn, :update, schdule), schdule: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Schdule"
    end
  end

  describe "delete schdule" do
    setup [:create_schdule]

    test "deletes chosen schdule", %{conn: conn, schdule: schdule} do
      conn = delete(conn, Routes.schdule_path(conn, :delete, schdule))
      assert redirected_to(conn) == Routes.schdule_path(conn, :index)
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
