defmodule GitExplorerWeb.FallbackController do
  use GitExplorerWeb, :controller

  alias GitExplorer.Error
  alias GitExplorerWeb.ErrorView

  def call(conn, {:error, %Error{reason: reason, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
