defmodule BleacherFireWeb.UsersController do
  use BleacherFireWeb, :controller

  #get the post reaction signature
  def index(conn, _params) do
    contents = get_bleacher_content()
    users = UsersServer.UsersAgent.get_state(:users_agent_process)
    render(conn, "index.html", posts: contents, users: users )
  end
end