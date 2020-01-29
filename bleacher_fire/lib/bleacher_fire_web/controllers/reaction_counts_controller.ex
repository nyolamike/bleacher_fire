#The Api Controller to get count of reactions of a particular content
defmodule BleacherFireWeb.ReactionCountsController do
  use BleacherFireWeb, :controller

  def index(conn,  %{"content_id" => content_id} = params) do
    #we need to ask the dashboard service to give us this count
    count = DashboardServer.DashboardAgent.get(:dashboard_agent_process,content_id)
    json(conn, count)
  end
  
end