defmodule ReactionsServerTest do
  use ExUnit.Case, async: true
  doctest ReactionsServer

  test "Stores users reactions by content_id " do
    request_pay_load = %{
      type: "reaction",
      action: "add",
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    {:ok, agent_process} = ReactionsServer.ReactionsAgent.start_link(%{})
    assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load.content_id) == nil

    ReactionsServer.ReactionsAgent.put(agent_process, request_pay_load.content_id, request_pay_load)
     assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load.content_id) == %{ request_pay_load.user_id => request_pay_load }
  end
end
