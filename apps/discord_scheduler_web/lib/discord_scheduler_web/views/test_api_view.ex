defmodule DiscordSchedulerWeb.TestApiView do
  use DiscordSchedulerWeb, :view
  alias DiscordSchedulerWeb.TestApiView

  def render("index.json", %{testapis: testapis}) do
    %{data: render_many(testapis, TestApiView, "test_api.json")}
  end

  def render("show.json", %{test_api: test_api}) do
    %{data: render_one(test_api, TestApiView, "test_api.json")}
  end

  def render("test_api.json", %{test_api: test_api}) do
    %{id: test_api.id,
      title: test_api.title}
  end
end
