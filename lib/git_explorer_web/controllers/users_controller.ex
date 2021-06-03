defmodule GitExplorerWeb.UsersController do
  use GitExplorerWeb, :controller

  action_fallback GitExplorerWeb.FallbackController

  def create(conn, params) do
    with {:ok, token} <- GitExplorer.sign_up_user(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", token: token)
    end
  end
end
