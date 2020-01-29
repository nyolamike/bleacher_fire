defmodule BleacherFireWeb.ReactionCountsControllerTest do
  use BleacherFireWeb.ConnCase

  test "GET 404 on /api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999", %{conn: conn} do
    conn = get(conn, "/api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999")
    html_body = html_response(conn, 404)
    assert html_body == ""
  end

  test "GET /api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-687", %{conn: conn} do
    #first add in a post
    content_id = "7056af828-2efe-4631-8446-75tdxxx-687"
    user_id = "some_user@bleacher_fire.com"
    conn = post(conn, "/api/reaction", %{
        type: "reaction", 
        action: "add", 
        content_id: content_id,
        user_id:  user_id,
        reaction_type: "fire"
    })
    conn = get(conn, "/api/reaction_counts/" <> content_id)
    body = json_response(conn, 200)
    assert Map.has_key?(body, "reaction_count") and body["reaction_count"] == %{"fire" => 1}
  end
  
end