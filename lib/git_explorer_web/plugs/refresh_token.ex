defmodule GitExplorerWeb.Plugs.RefreshToken do
  import Plug.Conn

  alias GitExplorer.Auth.Guardian
  alias GitExplorer.Auth.Guardian.Plug, as: GuardianPlug

  @behaviour Plug

  @impl true
  def init(options), do: options

  @impl true
  def call(conn, _options) do
    {:ok, _old_stuff, {new_token, _new_claims}} =
      conn
      |> GuardianPlug.current_token()
      |> Guardian.refresh()

    conn
    |> put_resp_header("authorization", "Bearer #{new_token}")
  end
end
