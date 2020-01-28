defmodule UsersServerTest do
  use ExUnit.Case, async: true
  doctest UsersServer

  test "Stores users content_ids of reactions " do
    request_pay_load = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    {:ok, agent_process} = ReactionsServer.UsersAgent.start_link(%{})
    assert ReactionsServer.UsersAgent.get(agent_process, request_pay_load.user_id) == nil

    ReactionsServer.UsersAgent.put(agent_process, request_pay_load.content_id, request_pay_load)
    assert ReactionsServer.UsersAgent.get(agent_process, request_pay_load.content_id) == %{ request_pay_load.user_id => [request_pay_load.content_id] }
  end


end
