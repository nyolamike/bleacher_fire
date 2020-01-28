defmodule UsersServer.UsersAgent do
  use Agent

  @doc """
  Starts a new agent process to store user content reactions.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets the reactions list of a user by `user_id`.
  """
  def get(agent_process, user_id) do
    Agent.get(agent_process, &Map.get(&1, user_id))
  end

  @doc """
  A helper function to get the state of the store
  """
  def get_state(agent_process) do
    Agent.get(agent_process, &(&1))
  end

  @doc """
  Stores a users `content_ids` to a store by `user_id` 
  """
  def put(agent_process, user_id, content_id) do
    Agent.update(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, user_id ) == false do
            Map.put(reactions, user_id, [content_id])
        else
            if content_id in reactions[user_id] == false do
                %{ reactions | user_id => [content_id | reactions[user_id] ] }
            else
                reactions #if we already have it then we just return our state
            end
        end 
    end)
  end

  @doc """
  Removes a users reaction 
  """
  def remove(agent_process, user_id, content_id) do
    Agent.update(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, user_id ) == false do
            reactions
        else
            if content_id in reactions[user_id] == false do
                reactions #if we already have it then we just return our state
            else
                %{ reactions | user_id => List.delete(reactions[user_id], content_id)}
            end
        end 
    end)
  end

  @doc """
  Checks if a users has a  reaction to the content
  """
  def has_reaction(agent_process, user_id, content_id) do
    Agent.get(agent_process, fn reactions ->
        #check if this content already has a reaction here
        if Map.has_key?(reactions, user_id ) == false do
          false
        else
          content_id in reactions[user_id]
        end 
    end)
  end

end