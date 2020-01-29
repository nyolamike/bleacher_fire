#The Api Controller to post reactions either add or remove
defmodule BleacherFireWeb.ReactionController do
  use BleacherFireWeb, :controller

  def index(conn,  %{ "action" => action} = params) when action == "add" do
    IO.inspect(params)
    #we need to ask the reactions microservice to add this reaction
    # ReactionsServer.ReactionsAgent.put(:reactions_agent_process, params.content_id, reaction)
    json(conn, %{})
  end
  
end