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

  test "POST 200 /api/reaction remove  ", %{conn: conn} do
    #first add the content
    content_id = "7056af828-2efe-4631-8446-75tdyyy-8888"
    user_id = "some_user@bleacher_fire.com"
    conn = post(conn, "/api/reaction", %{
        type: "reaction", 
        action: "add", 
        content_id: content_id,
        user_id:  user_id,
        reaction_type: "fire"
    })
    #then we can delete it
    conn = post(conn, "/api/reaction", %{
        type: "reaction", 
        action: "remove", 
        content_id: content_id,
        user_id:  user_id,
        reaction_type: "fire"
    })
    response = json_response(conn, 200)
    assert Map.has_key?(response, user_id) and response[user_id]["user_id"]  == user_id
    #when we try to count it will give us 1
    conn = get(conn, "/api/reaction_counts/" <> content_id)
    body = json_response(conn, 200)
    assert Map.has_key?(body, "reaction_count") and body["reaction_count"] == %{"fire" => 0}
  end


end