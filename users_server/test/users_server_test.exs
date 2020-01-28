defmodule UsersServerTest do
  use ExUnit.Case
  doctest UsersServer

  test "greets the world" do
    assert UsersServer.hello() == :world
  end
end
