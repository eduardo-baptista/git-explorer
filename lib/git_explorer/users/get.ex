defmodule GitExplorer.Users.Get do
  alias GitExplorer.Users.User
  alias GitExplorer.{Error, Repo}

  def get_by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      user -> {:ok, user}
    end
  end
end
