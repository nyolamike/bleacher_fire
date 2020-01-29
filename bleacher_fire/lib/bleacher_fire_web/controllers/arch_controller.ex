defmodule BleacherFireWeb.ArchController do
  use BleacherFireWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end