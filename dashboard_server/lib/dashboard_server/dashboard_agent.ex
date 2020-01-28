defmodule DashboardServer.DashboardAgent do
  use Agent

  @doc """
  Starts a new agent process to store user content reactions.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets the reactions count of a content by `content_id`.
  """
  def get(agent_process, content_id) do
    Agent.get(agent_process, fn register -> 
        if Map.has_key?(register, content_id) do
            %{ 
                content_id: content_id, 
                reaction_count:  %{ fire: register[content_id] }
            }
        else
            %{ 
                content_id: content_id, 
                reaction_count: %{ fire: 0}  
            }
        end
    end)
  end

  @doc """
  A helper function to get the state of the store
  """
  def get_state(agent_process) do
    Agent.get(agent_process, &(&1))
  end

  @doc """
  Increaments the count of a reaction content by  `content_id`
  """
  def increament(agent_process, content_id) do
    Agent.update(agent_process, fn register ->
        #check if this content already has a reaction entry here
        if Map.has_key?(register, content_id) do
            #increment
            %{  register | content_id => register[content_id] + 1 }
        else
            #we add a new one here
            Map.put(register, content_id, 1)
        end
    end)
  end

end