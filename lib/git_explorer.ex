defmodule GitExplorer do
  @moduledoc """
  GitExplorer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias GitExplorer.Repositories.Get

  defdelegate get_repos_by_user(user), to: Get, as: :get_by_user
end
