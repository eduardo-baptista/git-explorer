defmodule GitExplorerWeb.SessionsController do
  use GitExplorerWeb, :controller

  action_fallback GitExplorerWeb.FallbackController

  def create(conn, params) do
    with {:ok, token} <- GitExplorer.sign_in_user(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", token: token)
    end
  end
end
