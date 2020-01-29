defmodule BleacherFireWeb.ReactionControllerTest do
  use BleacherFireWeb.ConnCase

  test "POST /api/reaction add ", %{conn: conn} do
    content_id = "7056af828-2efe-4631-8446-75tdxxx-8888"
    user_id = "some_user@bleacher_fire.com"
    conn = post(conn, "/api/reaction", %{
        type: "reaction", 
        action: "add", 
        content_id: content_id,
        user_id:  user_id,
        reaction_type: "fire"
    })
    response = json_response(conn, 200)
    assert Map.has_key?(response, user_id) and response[user_id]["user_id"]  == user_id
  end

  test "POST 404 /api/reaction remove  ", %{conn: conn} do
    content_id = "7056af828-hh2efe-4631-xd8446-75tdxxx-8118"
    user_id = "some_user@bleacher_fire.com"
    conn = post(conn, "/api/reaction", %{
        type: "reaction", 
        action: "remove", 
        content_id: content_id,
        user_id:  user_id,
        reaction_type: "fire"
    })
    html_body = html_response(conn, 404)
    assert html_body == ""
  end


end