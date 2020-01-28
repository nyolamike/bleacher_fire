defmodule UsersServerTest do
  use ExUnit.Case, async: true
  doctest UsersServer

  test "Stores users content_ids of reactions " do
    request_pay_load = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    {:ok, agent_process} = UsersServer.UsersAgent.start_link(%{})
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load.user_id) == nil

    UsersServer.UsersAgent.put(agent_process, request_pay_load.user_id, request_pay_load.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load.user_id) ==  [request_pay_load.content_id]

    #add another comment reaction
    request_pay_load_2 = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67368",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    UsersServer.UsersAgent.put(agent_process, request_pay_load_2.user_id, request_pay_load_2.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_2.user_id) ==  [request_pay_load_2.content_id, request_pay_load.content_id]
  
    #add another 3 reaction by another user
    request_pay_load_3 = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67368",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f02f"
    }
    UsersServer.UsersAgent.put(agent_process, request_pay_load_3.user_id, request_pay_load_3.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_3.user_id) ==  [request_pay_load_3.content_id]
  
  end

  test "Delets users reactions from registry" do
    request_pay_load = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    {:ok, agent_process} = UsersServer.UsersAgent.start_link(%{})
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load.user_id) == nil

    UsersServer.UsersAgent.put(agent_process, request_pay_load.user_id, request_pay_load.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load.user_id) ==  [request_pay_load.content_id]

    #add another comment reaction
    request_pay_load_2 = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67368",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    UsersServer.UsersAgent.put(agent_process, request_pay_load_2.user_id, request_pay_load_2.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_2.user_id) ==  [request_pay_load_2.content_id, request_pay_load.content_id]
  
    #add another 3 reaction by another user
    request_pay_load_3 = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67368",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f02f"
    }
    UsersServer.UsersAgent.put(agent_process, request_pay_load_3.user_id, request_pay_load_3.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_3.user_id) ==  [request_pay_load_3.content_id]

    #delete the users content reaction
    UsersServer.UsersAgent.remove(agent_process, request_pay_load_2.user_id, request_pay_load_2.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_2.user_id) ==  [request_pay_load.content_id]

    UsersServer.UsersAgent.remove(agent_process, request_pay_load_3.user_id, request_pay_load_3.content_id)
    assert UsersServer.UsersAgent.get(agent_process, request_pay_load_3.user_id) ==  []
  
  end

  test "Check if a user has a reaction to a content" do
    request_pay_load = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    {:ok, agent_process} = UsersServer.UsersAgent.start_link(%{})
    assert UsersServer.UsersAgent.has_reaction(agent_process, request_pay_load.user_id) == false

    UsersServer.UsersAgent.put(agent_process, request_pay_load.user_id, request_pay_load.content_id)
    assert UsersServer.UsersAgent.has_reaction(agent_process, request_pay_load.user_id,  request_pay_load.content_id)  ==  true

    #add another comment reaction
    request_pay_load_2 = %{
      content_id: "056af828-2efe-4631-8446-c52cabb67368",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e"
    }
    assert UsersServer.UsersAgent.has_reaction(agent_process, request_pay_load_2.user_id, request_pay_load_2.content_id) ==  false
  
  end

  


end
