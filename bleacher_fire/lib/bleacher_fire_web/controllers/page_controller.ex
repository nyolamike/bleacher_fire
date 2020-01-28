defmodule BleacherFireWeb.PageController do
  use BleacherFireWeb, :controller

  def index(conn, _params) do
    request_pay_load = %{
      type: "reaction",
      action: "add",
      content_id: "056af828-2efe-4631-8446-c52cabb67367",
      user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
      reaction_type: "fire"
    }
    ReactionsServer.ReactionsAgent.put(
      :reactions_agent_process, 
      request_pay_load.content_id, 
      request_pay_load
    )
    state = ReactionsServer.ReactionsAgent.get_state(:reactions_agent_process)
    IO.puts("Testing this ")
    IO.inspect(state)
    render(conn, "index.html")
  end
end
