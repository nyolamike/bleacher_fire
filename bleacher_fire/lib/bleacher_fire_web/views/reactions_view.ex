defmodule BleacherFireWeb.ReactionsView do
  use BleacherFireWeb, :view

  
  def post_link_class(content_id, selected_content_id) do
    defaultClass = "post-side "
    if content_id == selected_content_id do
      defaultClass <> " selected-side-post "
    else
      defaultClass  
    end
  end
end