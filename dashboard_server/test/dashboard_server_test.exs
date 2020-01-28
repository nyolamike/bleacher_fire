defmodule DashboardServerTest do
  use ExUnit.Case
  doctest DashboardServer

  test "greets the world" do
    assert DashboardServer.hello() == :world
  end
end
