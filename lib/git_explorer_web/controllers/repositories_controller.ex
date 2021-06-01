defmodule GitExplorerWeb.RepositoriesController do
  use GitExplorerWeb, :controller

  action_fallback GitExplorerWeb.FallbackController

  def index(conn, %{"user" => user}) do
    with {:ok, repos} <- GitExplorer.get_repos_by_user(user) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos)
    end
  end
end
