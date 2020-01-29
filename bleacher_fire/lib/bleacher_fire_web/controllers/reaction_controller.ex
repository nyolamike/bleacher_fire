#The Api Controller to post reactions either add or remove
defmodule BleacherFireWeb.ReactionController do
  use BleacherFireWeb, :controller

  #get the post reaction signature
  @create_params [:type, :action, :content_id, :user_id, :reaction_type]
  def index(conn,  %{ "action" => action} = params) when action == "add" do
    entry = strong_params(params, @create_params)
    #we need to ask the reactions microservice to add this reaction
    ReactionsServer.ReactionsAgent.put(:reactions_agent_process, entry.content_id, entry)
    reaction = ReactionsServer.ReactionsAgent.get(:reactions_agent_process, entry.content_id)
    #we need to tell the dashboard service that some one has reacted to increament the count
    DashboardServer.DashboardAgent.increament(:dashboard_agent_process,entry.content_id)
    #we need to tell the users service about this awesome event
    UsersServer.UsersAgent.put(:users_agent_process, entry.user_id, entry.content_id)
    json(conn, reaction)
  end

  #get the post reaction signature for remove reaction
  @remove_params [:type, :action, :content_id, :user_id, :reaction_type]
  def index(conn,  %{ "action" => action} = params) when action == "remove" do
    entry = strong_params(params, @remove_params)
    #first try to get the reaction that is going to be deleted
    reaction = ReactionsServer.ReactionsAgent.get(:reactions_agent_process, entry.content_id)
    if reaction != nil do
      #we need to ask the reactions microservice to remove this reaction
      ReactionsServer.ReactionsAgent.remove(:reactions_agent_process, entry)
      #we need to tell the dashboard service that some one has unreacted to decreament the count
      DashboardServer.DashboardAgent.decreament(:dashboard_agent_process,entry.content_id)
      #we need to tell the users service about this unfortunate event
      UsersServer.UsersAgent.remove(:users_agent_process, entry.user_id, entry.content_id)
      json(conn, reaction)
    else
      #return 404 for any unkown content_id values
      html(put_status(conn,:not_found),"")
    end
  end
  
end