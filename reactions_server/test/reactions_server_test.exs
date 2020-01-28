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

  
  test "Deletes a users reaction of a certain content by user_id " do
    request_pay_load_1 = %{
      type: "reaction",
      action: "add",
      content_id: "056af828-2efe-4631-8446-c52cabb67549",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    request_pay_load_2 = %{
      type: "reaction",
      action: "add",
      content_id: "056af828-2efe-4631-8446-c52cabb67549",
      user_id: "9e304fff-9b49-4100-8b22-6cc88be2f02g",
      reaction_type: "fire"
    }
    request_pay_load_3 = %{
      type: "reaction",
      action: "add",
      content_id: "056af828-2efe-4631-8446-c52cabb67550",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    {:ok, agent_process} = ReactionsServer.ReactionsAgent.start_link(%{})
    assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load_1.content_id) == nil

    #add reactions
    ReactionsServer.ReactionsAgent.put(agent_process, request_pay_load_1.content_id, request_pay_load_1)
    ReactionsServer.ReactionsAgent.put(agent_process, request_pay_load_2.content_id, request_pay_load_2)
    ReactionsServer.ReactionsAgent.put(agent_process, request_pay_load_3.content_id, request_pay_load_3)
    #check that reactions exist
    assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load_1.content_id) != nil
    assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load_2.content_id) != nil
    assert ReactionsServer.ReactionsAgent.get(agent_process, request_pay_load_3.content_id) != nil

    #delete reation 2
    delete_pay_load_1 = %{
      type: "reaction",
      action: "remove",
      content_id: "056af828-2efe-4631-8446-c52cabb67549",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    delete_pay_load_2 = %{
      type: "reaction",
      action: "remove",
      content_id: "056af828-2efe-4631-8446-c52cabb67549",
      user_id: "9e304fff-9b49-4100-8b22-6cc88be2f02g",
      reaction_type: "fire"
    }
    delete_pay_load_3 = %{
      type: "reaction",
      action: "remove",
      content_id: "056af828-2efe-4631-8446-c52cabb67550",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    ReactionsServer.ReactionsAgent.remove(agent_process, delete_pay_load_1)
    ReactionsServer.ReactionsAgent.remove(agent_process, delete_pay_load_2)
    ReactionsServer.ReactionsAgent.remove(agent_process, delete_pay_load_3)
    #assert that the reactions for the users donnot exist
    assert ReactionsServer
      .ReactionsAgent
      .get(agent_process, request_pay_load_1.content_id)[request_pay_load_1.user_id] == nil
    assert ReactionsServer
      .ReactionsAgent
      .get(agent_process, request_pay_load_2.content_id)[request_pay_load_2.user_id] == nil
    assert ReactionsServer
      .ReactionsAgent
      .get(agent_process, request_pay_load_3.content_id)[request_pay_load_3.user_id] == nil

    
  end


end
