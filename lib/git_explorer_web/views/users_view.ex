defmodule GitExplorerWeb.UsersView do
  use GitExplorerWeb, :view

  def render("create.json", %{token: token}), do: %{token: token}
end
