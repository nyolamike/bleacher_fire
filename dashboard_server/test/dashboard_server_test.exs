defmodule DashboardServerTest do
  use ExUnit.Case, async: true
  doctest DashboardServer

  test "Increments count for a particular content_id " do
    content_id =  "056af828-2efe-4631-8446-c52cabb67367"
    {:ok, agent_process} = DashboardServer.DashboardAgent.start_link(%{})
    empty_value = %{ content_id: content_id, reaction_count: %{ fire: 0}  }
    assert DashboardServer.DashboardAgent.get(agent_process, content_id) == empty_value

    DashboardServer.DashboardAgent.increament(agent_process, content_id)
    some_value = %{ content_id: content_id, reaction_count: %{ fire: 1}  }
    assert DashboardServer.DashboardAgent.get(agent_process, content_id) == some_value

    DashboardServer.DashboardAgent.increament(agent_process, content_id)
    some_value = %{ content_id: content_id, reaction_count: %{ fire: 2}  }
    assert DashboardServer.DashboardAgent.get(agent_process, content_id) == some_value

    content_id =  "056af828-2efe-4631-8446-c52cabb6756"
    DashboardServer.DashboardAgent.increament(agent_process, content_id)
    some_new_value = %{ content_id: content_id, reaction_count: %{ fire: 1}  }
    assert DashboardServer.DashboardAgent.get(agent_process, content_id) == some_new_value
  end
end
