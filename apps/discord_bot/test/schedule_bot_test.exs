defmodule ScheduleBotTest do
  use ExUnit.Case
  doctest ScheduleBot

  test "greets the world" do
    assert ScheduleBot.hello() == :world
  end
end
