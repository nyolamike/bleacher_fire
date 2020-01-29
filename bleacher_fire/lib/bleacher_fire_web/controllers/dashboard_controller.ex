defmodule BleacherFireWeb.DashboardController do
  use BleacherFireWeb, :controller

  #get the post reaction signature
  def index(conn, _params) do
    contents = get_bleacher_content()
    dashboard_state = DashboardServer.DashboardAgent.get_state(:dashboard_agent_process)
    total_reactions = Enum.reduce(dashboard_state, 0, fn {_content_id, count}, acc  -> 
        acc + count
    end)
    users_count = map_size(UsersServer.UsersAgent.get_state(:users_agent_process))
    render(conn, "index.html", posts: contents, stats: dashboard_state, total: total_reactions, users_num: users_count )
  end
end