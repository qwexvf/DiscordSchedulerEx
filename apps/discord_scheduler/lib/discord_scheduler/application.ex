defmodule DiscordScheduler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DiscordScheduler.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DiscordScheduler.PubSub}
      # Start a worker by calling: DiscordScheduler.Worker.start_link(arg)
      # {DiscordScheduler.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: DiscordScheduler.Supervisor)
  end
end
