defmodule BleacherFireWeb.PageControllerTest do
  use BleacherFireWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "it"
  end
end
