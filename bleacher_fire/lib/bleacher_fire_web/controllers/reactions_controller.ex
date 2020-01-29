defmodule BleacherFireWeb.ReactionsController do
  use BleacherFireWeb, :controller

  def get_bleacher_content() do
    content_id_1 = "056af828-2efe-4631-8446-c52cabb67367"
    content_id_2 = "04631828-2efe-4631-7642-c52cabb64631"
    content_id_3 = "0fx56828-2efe-4631-fx56-c52cabb6fx56"
    content_id_4 = "046ty679-2efe-4631-y679-c52cabb6y679"
    %{
        content_id_1 => %{
            image: "https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=80",
            text: "The Ballwent Like a rolling code base.",
            content_id: content_id_1
        },
        content_id_2 => %{
            image: "https://images.unsplash.com/photo-1504450758481-7338eba7524a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=80",
            text: "Concurrency is a first class citizen @all things Elixir.",
            content_id: content_id_2
        },
        content_id_3 => %{
            image: "https://images.unsplash.com/photo-1550171362-62bca9e5ad4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=60",
            text: "Actor Model Achitectures have a very high scallability factor.",
            content_id: content_id_1
        },
        content_id_4 => %{
            image: "https://images.unsplash.com/photo-1574623452334-1e0ac2b3ccb4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=60",
            text: "Microservices, I dont really think they are like balls bouncing around or may be !!!",
            content_id: content_id_4
        }
    }
  end

  def index(conn,  %{"user_name" => user_id} = params) do
    contents = get_bleacher_content()
    #get this users reactions to the content to be rendered
    for { content_id, content}  <- contents do
        #IO.puts("another one #{content_id}")
        reactions = ReactionsServer.ReactionsAgent.get(:reactions_agent_process,content_id)
        IO.inspect(reactions)
    end
    
    render(conn, "index.html")
  end

  def index(conn, params) do
  #get this users reactions to these posts
    # request_pay_load = %{
    #   type: "reaction",
    #   action: "add",
    #   content_id: "056af828-2efe-4631-8446-c52cabb67367",
    #   user_id: "9e204fff-9b48-4000-8b21-6cc88be2f01e",
    #   reaction_type: "fire"
    # }
    # ReactionsServer.ReactionsAgent.put(
    #   :reactions_agent_process, 
    #   request_pay_load.content_id, 
    #   request_pay_load
    # )
    # state = ReactionsServer.ReactionsAgent.get_state(:reactions_agent_process)
    # IO.puts("Testing this ")
    # IO.inspect(state)
    render(conn, "index.html")
  end

  
end