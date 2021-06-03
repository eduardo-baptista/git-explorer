defmodule GitExplorer.Users.SignIn do
  alias GitExplorer.Auth.Guardian
  alias GitExplorer.Error
  alias GitExplorer.Users.Get, as: UserGet
  alias GitExplorer.Users.User

  def call(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.get_by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, token}
    else
      _ -> {:error, Error.build("Authentication failed", :unauthorized)}
    end
  end
end
