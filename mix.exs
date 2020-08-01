defmodule DiscordScheduler.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.0.1",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases(),
      default_release: :app,
    ]
  end

  defp releases do
    [
      include_executables_for: [:unix],
      app: [
        applications: [
          discord_scheduler: :permanent,
          discord_scheduler_web: :permanent,
          discord_bot: :permanent
        ]
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:exq, "~> 0.13.5"},
      {:timex, "~> 3.5"},
      {:arc, "~> 0.11.0"},
      {:arc_ecto, "~> 0.11.3"},
      {:jason, "~> 1.1"}
    ]
  end
end
