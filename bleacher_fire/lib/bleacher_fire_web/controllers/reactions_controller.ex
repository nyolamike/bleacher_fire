defmodule BleacherFireWeb.ReactionsController do
  use BleacherFireWeb, :controller

  

  def details(conn,  %{"user_name" => user_id, "id" => selected_content_id} = _params) do
    contents = get_bleacher_content()
    #get this users reactions to the content to be rendered
    user_reactions = Enum.reduce(contents, %{}, fn {content_id, _content}, acc  -> 
        user_reacted = UsersServer.UsersAgent.has_reaction(:users_agent_process,user_id,content_id)
        Map.put(acc, content_id, user_reacted )
    end)
    conn
    |>render("details.html", selected_post: contents[selected_content_id],  posts: contents, reactions: user_reactions, user_id: user_id, selected_content_id: selected_content_id  )
  end

  def index(conn,  %{"user_name" => user_id} = _params) do
    contents = get_bleacher_content()
    #get this users reactions to the content to be rendered
    user_reactions = Enum.reduce(contents, %{}, fn {content_id, _content}, acc  -> 
        user_reacted = UsersServer.UsersAgent.has_reaction(:users_agent_process,user_id,content_id)
        Map.put(acc, content_id, user_reacted )
    end)
    conn
    |>render("index.html", posts: contents, reactions: user_reactions, user_id: user_id  )
  end

  def index(conn, _params) do
    contents = get_bleacher_content()
    user_reactions = Enum.reduce(contents, %{}, fn {content_id, _content}, acc  -> 
        Map.put(acc, content_id, false )
    end)
    conn
    |> put_flash(:error, "Please Sign in, to load your reactions state from the <Users Server> micro service")
    |>render("index.html", posts: contents, reactions: user_reactions, user_id: ""  )
  end

  

  
end