defmodule DiscordBot.Command do
  alias Nostrum.Api
  alias DiscordBot.ErrorHandler

  @command_prefix "/schedule"

  defp actionable_command?(message) do
    if message.author.bot == nil do
      true
    end
  end

  def handle(message) do
    if actionable_command?(message) do 
      message.content
      |> String.trim
      |> String.split
      |> execute(message)
    end
  end

  def execute([@command_prefix, "ping"], message) do
    Api.create_message!(message.channel_id, "pong!")
  end

  def execute([@command_prefix], _) do
    :noop
  end

  def execute([_], _) do
    :noop
  end
end
