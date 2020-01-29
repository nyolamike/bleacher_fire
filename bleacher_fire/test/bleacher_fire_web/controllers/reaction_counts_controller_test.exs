defmodule BleacherFireWeb.ReactionCountsControllerTest do
  use BleacherFireWeb.ConnCase

  test "GET /api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999", %{conn: conn} do
    conn = get(conn, "/api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999")
    body = json_response(conn, 200)
    assert Map.has_key?(body, "reaction_count") and body["reaction_count"] == %{"fire" => 0}
  end
  
end