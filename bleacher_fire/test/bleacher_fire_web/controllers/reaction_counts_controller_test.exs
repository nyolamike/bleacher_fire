defmodule BleacherFireWeb.ReactionCountsControllerTest do
  use BleacherFireWeb.ConnCase

  test "GET 404 on /api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999", %{conn: conn} do
    conn = get(conn, "/api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-999")
    html_body = html_response(conn, 404)
    assert html_body == ""
  end

  # test "GET /api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-777", %{conn: conn} do
  #   #first add in a post

  #   conn = get(conn, "/api/reaction_counts/7056af828-2efe-4631-8446-75tdxxx-777")
  #   html_body = html_response(conn, 404)
  #   assert html_body == ""

    
  #   # IO.inspect(body)
  #   # assert Map.has_key?(body, "reaction_count") and body["reaction_count"] == %{"fire" => 0}
  # end
  
end