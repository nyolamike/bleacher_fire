defmodule DashboardServerTest do
  use ExUnit.Case, async: true
  doctest DashboardServer

  test "Increments count for a particular content_id " do
    content_id =  "056af828-2efe-4631-8446-c52cabb67367"
    {:ok, agent_process} = ReactionsServer.DashboardAgent.start_link(%{})
    assert ReactionsServer.DashboardAgent.get(agent_process, content_id) == 0

    ReactionsServer.DashboardAgent.increament(agent_process, content_id)
    assert ReactionsServer.DashboardAgent.get(agent_process, content_id) == 1
  end
end
