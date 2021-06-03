defmodule GitExplorer.Auth.Guardian do
  use Guardian, otp_app: :git_explorer

  alias GitExplorer.Users.Get, as: UserGet
  alias GitExplorer.Users.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.get_by_id()
  end
end
