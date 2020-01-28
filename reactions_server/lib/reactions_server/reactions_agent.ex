defmodule ReactionsServer.ReactionsAgent do
  use Agent

  @doc """
  Starts a new agent process to store user content reactions.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets the reactions map of a content by `content_id`.
  """
  def get(agent_process, content_id) do
    Agent.get(agent_process, &Map.get(&1, content_id))
  end

  @doc """
  A helper function to get the state of the store
  """
  def get_state(agent_process) do
    Agent.get(agent_process, &(&1))
  end

  @doc """
  Stores a users `reaction` to a given content by  `content_id` and `user_id` in the reactions.
  """
  def put(agent_process, content_id, reaction) do
    Agent.update(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, content_id) do
            #to ensure that only unique reactions are stored, 
            #the user service is first called
            #so we dont need to check here
            %{ reactions | content_id =>  Map.put(reactions[content_id], reaction.user_id, reaction) }
        else
            #we add a new one hear
            Map.put(reactions, content_id, %{ reaction.user_id => reaction })
        end
    end)
  end

  @doc """
  Removes a users reaction 
  """
  def remove(agent_process, reaction) do
    Agent.update(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, reaction.content_id) do
            #the user service will already provide prove that this user has this reaction
            %{ reactions | reaction.content_id => Map.delete(reactions[reaction.content_id], reaction.user_id) }
        else
            reactions
        end
    end)
  end

end