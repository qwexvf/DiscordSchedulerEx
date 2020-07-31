defmodule DiscordBot do
  @moduledoc """
  Documentation for ScheduleBot.
  """
  use Nostrum.Consumer
  alias DiscordBot.Command

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {message}, _ws_state}) do
    Command.handle(message)
  end

  def handle_event(_event) do
    :noop
  end
end
