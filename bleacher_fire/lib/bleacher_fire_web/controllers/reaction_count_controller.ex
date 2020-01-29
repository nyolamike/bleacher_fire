#The Api Controller to get count of reactions of a particular content
defmodule BleacherFireWeb.ReactionCountController do
  use BleacherFireWeb, :controller

  def index(conn,  %{"content_id" => content_id} = params) do
    json(conn, %{ 
      content_id: content_id,
      reactions_count: %{ fire: 15}
    })
  end
  
end