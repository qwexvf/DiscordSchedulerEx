defmodule DiscordSchedulerWeb.TestApiController do
  use DiscordSchedulerWeb, :controller

  alias DiscordScheduler.TestApis
  alias DiscordScheduler.TestApis.TestApi

  action_fallback DiscordSchedulerWeb.FallbackController

  def index(conn, _params) do
    testapis = TestApis.list_testapis()
    render(conn, "index.json", testapis: testapis)
  end

  def create(conn, %{"test_api" => test_api_params}) do
    with {:ok, %TestApi{} = test_api} <- TestApis.create_test_api(test_api_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.test_api_path(conn, :show, test_api))
      |> render("show.json", test_api: test_api)
    end
  end

  def show(conn, %{"id" => id}) do
    test_api = TestApis.get_test_api!(id)
    render(conn, "show.json", test_api: test_api)
  end

  def update(conn, %{"id" => id, "test_api" => test_api_params}) do
    test_api = TestApis.get_test_api!(id)

    with {:ok, %TestApi{} = test_api} <- TestApis.update_test_api(test_api, test_api_params) do
      render(conn, "show.json", test_api: test_api)
    end
  end

  def delete(conn, %{"id" => id}) do
    test_api = TestApis.get_test_api!(id)

    with {:ok, %TestApi{}} <- TestApis.delete_test_api(test_api) do
      send_resp(conn, :no_content, "")
    end
  end
end
