defmodule BleacherFireWeb.LayoutView do
  use BleacherFireWeb, :view

  def menu_link_class(conn, path) do
    defaultClass = "pure-menu-heading pure-menu-link "
    if path == Phoenix.Controller.current_path(conn, %{}) do
      defaultClass <> " pure-menu-selected " 
    else
      defaultClass
    end
  end

end
