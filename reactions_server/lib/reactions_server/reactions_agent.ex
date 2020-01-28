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
  Stores a users `reaction` to a given content by  `content_id` and `user_id` in the reactions.
  """
  def put(agent_process, content_id, reaction) do
    Agent.update(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, content_id) do
            #to ensure that only unique reactions are stored, 
            #the user service is first called
            #so we dont need to check here
            Map.put(reactions[content_id], reaction.user_id, reaction)
        else
            #we add a new one hear
            Map.put(reactions, content_id, %{ reaction.user_id => reaction })
        end
    end)
  end

end