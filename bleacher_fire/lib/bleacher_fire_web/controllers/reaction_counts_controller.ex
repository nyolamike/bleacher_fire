#The Api Controller to get count of reactions of a particular content
defmodule BleacherFireWeb.ReactionCountsController do
  use BleacherFireWeb, :controller

  def index(conn,  %{"content_id" => content_id} = _params) do
    #check if we have this content
    reaction = ReactionsServer.ReactionsAgent.get(:reactions_agent_process, content_id)
    if reaction != nil do
      #we need to ask the dashboard service to give us this count
      count = DashboardServer.DashboardAgent.get(:dashboard_agent_process,content_id)
      json(conn, count)
    else
      #return 404 for any unkown content_id values
      html(put_status(conn,:not_found),"")
    end
  end
  
end 