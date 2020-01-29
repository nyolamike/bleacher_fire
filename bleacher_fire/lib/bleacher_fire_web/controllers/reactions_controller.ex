defmodule BleacherFireWeb.ReactionsController do
  use BleacherFireWeb, :controller

  def get_bleacher_content() do
    content_id_1 = "056af828-2efe-4631-8446-c52cabb67367"
    content_id_2 = "04631828-2efe-4631-7642-c52cabb64631"
    content_id_3 = "0fx56828-2efe-4631-fx56-c52cabb6fx56"
    content_id_4 = "046ty679-2efe-4631-y679-c52cabb6y679"
    content_id_5 = "056af825-2efe-4635-8446-c52cabb67365"
    content_id_6 = "04631826-2efe-4636-7642-c52cabb64636"
    content_id_7 = "0fx56827-2efe-4637-fx56-c52cabb6fx57"
    content_id_8 = "046ty678-2efe-4638-y679-c52cabb6y678"
    %{
        content_id_1 => %{
            author: "Nyola Mike",
            image: "https://images.unsplash.com/photo-1546519638-68e109498ffc?ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=80",
            text: "The Ballwent Like a rolling code base.",
            content_id: content_id_1
        },
        content_id_2 => %{
            author: "Dott Nyo",
            image: "https://images.unsplash.com/photo-1504450758481-7338eba7524a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=80",
            text: "Concurrency is a first class citizen @all things Elixir.",
            content_id: content_id_2
        },
        content_id_3 => %{
            author: "Rusticle ",
            image: "https://images.unsplash.com/photo-1552667466-07770ae110d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=50&q=60",
            text: "Actor Model Achitectures have a very high scallability factor.",
            content_id: content_id_3
        },
        content_id_4 => %{
            author: "Nyola Mike",
            image: "https://images.unsplash.com/photo-1574623452334-1e0ac2b3ccb4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=60",
            text: "Microservices, I dont really think they are like balls bouncing around or may be !!!",
            content_id: content_id_4
        },
        content_id_5 => %{
            author: "Nyola Mike",
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZcVRROrYO0VZds1M0xCD06wnh3P0sLe4pNk8pvQHbDUun7rJH&s",
            text: "Its not a race, no one size fits all, but it all depends -dotnyo",
            content_id: content_id_5
        },
        content_id_6 => %{
            author: "Dott Nyo",
            image: "https://images.unsplash.com/photo-1516684378628-240d2c5237f5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=80",
            text: "When did it all happen, we thought we hard refactored the code extremly, it still didnt scale.",
            content_id: content_id_6
        },
        content_id_7 => %{
            author: "Rusticle ",
            image: "https://images.unsplash.com/photo-1550171362-62bca9e5ad4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=60",
            text: "To whom much is given, much is expected and they all like it that way.",
            content_id: content_id_7
        },
        content_id_8 => %{
            author: "Nyola Mike",
            image: "https://images.unsplash.com/photo-1519861531473-9200262188bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=50&q=60",
            text: "You can break it up so finely but dont forget not to loose control, that how to do it.",
            content_id: content_id_8
        }
    }
  end

  def index(conn,  %{"user_name" => user_id} = params) do
    contents = get_bleacher_content()
    #get this users reactions to the content to be rendered
    user_reactions = Enum.reduce(contents, %{}, fn {content_id, content}, acc  -> 
        user_reacted = UsersServer.UsersAgent.has_reaction(:users_agent_process,user_id,content_id)
        Map.put(acc, content_id, user_reacted )
    end)
    conn
    |>render("index.html", posts: contents, reactions: user_reactions, user_id: user_id  )
  end

  def index(conn, params) do
    contents = get_bleacher_content()
    user_reactions = Enum.reduce(contents, %{}, fn {content_id, content}, acc  -> 
        Map.put(acc, content_id, false )
    end)
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
    conn
    |> put_flash(:error, "Please Sign in, to load your reactions state from the <Users Server> micro service")
    |>render("index.html", posts: contents, reactions: user_reactions, user_id: ""  )
  end

  
end