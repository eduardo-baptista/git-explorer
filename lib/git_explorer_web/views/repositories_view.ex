defmodule GitExplorerWeb.RepositoriesView do
  use GitExplorerWeb, :view

  def render("repos.json", %{repos: repos}) do
    %{repos: repos}
  end
end
