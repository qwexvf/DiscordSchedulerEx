defmodule DiscordSchedulerWeb.TestApiControllerTest do
  use DiscordSchedulerWeb.ConnCase

  alias DiscordScheduler.TestApis
  alias DiscordScheduler.TestApis.TestApi

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  def fixture(:test_api) do
    {:ok, test_api} = TestApis.create_test_api(@create_attrs)
    test_api
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all testapis", %{conn: conn} do
      conn = get(conn, Routes.test_api_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create test_api" do
    test "renders test_api when data is valid", %{conn: conn} do
      conn = post(conn, Routes.test_api_path(conn, :create), test_api: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.test_api_path(conn, :show, id))

      assert %{
               "id" => id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.test_api_path(conn, :create), test_api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update test_api" do
    setup [:create_test_api]

    test "renders test_api when data is valid", %{conn: conn, test_api: %TestApi{id: id} = test_api} do
      conn = put(conn, Routes.test_api_path(conn, :update, test_api), test_api: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.test_api_path(conn, :show, id))

      assert %{
               "id" => id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, test_api: test_api} do
      conn = put(conn, Routes.test_api_path(conn, :update, test_api), test_api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete test_api" do
    setup [:create_test_api]

    test "deletes chosen test_api", %{conn: conn, test_api: test_api} do
      conn = delete(conn, Routes.test_api_path(conn, :delete, test_api))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.test_api_path(conn, :show, test_api))
      end
    end
  end

  defp create_test_api(_) do
    test_api = fixture(:test_api)
    {:ok, test_api: test_api}
  end
end
