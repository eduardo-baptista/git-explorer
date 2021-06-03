defmodule GitExplorer.Users.SignUp do
  alias Ecto.Changeset
  alias GitExplorer.Auth.Guardian
  alias GitExplorer.Users.User
  alias GitExplorer.{Error, Repo}

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, user} <- Repo.insert(changeset),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, token}
    else
      {:error, %Changeset{} = changeset} -> {:error, Error.build(changeset, :bad_request)}
      _ -> {:error, Error.build("Failed to sign up", :bad_request)}
    end
  end
end
