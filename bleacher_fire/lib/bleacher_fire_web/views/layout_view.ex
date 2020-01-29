defmodule BleacherFireWeb.LayoutView do
  use BleacherFireWeb, :view

  def menu_link_class(conn, path) do
    defaultClass = "pure-menu-heading pure-menu-link "
    current = Phoenix.Controller.current_path(conn, %{})
    if (current =~ path and path != "/") or (path == current) do
      defaultClass <> " pure-menu-selected "
    else
      defaultClass  
    end
  end

end
