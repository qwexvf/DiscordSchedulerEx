defmodule DiscordSchedulerWeb.Router do
  use DiscordSchedulerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscordSchedulerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/schedules/:id/edit", PageController, :index
    get "/schedules/create", PageController, :index
    post "/schedules/:id/send", ScheduleController, :send
  end

  # Other scopes may use custom stacks.
  scope "/api", DiscordSchedulerWeb do
    pipe_through :api

    resources "/schedules", ScheduleController, exptect: [:edit, :new]
    post "/schedules/:id/send", ScheduleController, :send
    post "/schedules/deleteSelected", ScheduleController, :delete_schedule_from_list
  end
end
