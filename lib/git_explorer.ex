defmodule GitExplorer do
  @moduledoc """
  GitExplorer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias GitExplorer.Repositories.Get
  alias GitExplorer.Users.SignIn
  alias GitExplorer.Users.SignUp

  defdelegate get_repos_by_user(user), to: Get, as: :get_by_user
  defdelegate sign_in_user(params), to: SignIn, as: :call
  defdelegate sign_up_user(params), to: SignUp, as: :call
end
