defmodule BleacherFireWeb.ReactionControllerTest do
  use BleacherFireWeb.ConnCase

  test "POST /api/reaction add ", %{conn: conn} do
    content_id = "7056af828-2efe-4631-8446-75tdxxx-8888"
    conn = post(conn, "/api/reaction", %{
        "type" => "reaction", 
        "action" => "add", 
        "content_id" => content_id,
        "user_id" => "some_user@bleacher_fire.com",
        "reaction_type" => "fire"
    })
    body = json_response(conn, 200)
    assert Map.has_key?(body, "ok") and body["ok"] == true
  end
end