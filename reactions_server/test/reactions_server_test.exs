defmodule ReactionsServerTest do
  use ExUnit.Case, 
  doctest ReactionsServer

  test "greets the world" do
    assert ReactionsServer.hello() == :world
  end
end
