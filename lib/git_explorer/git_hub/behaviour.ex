defmodule GitExplorer.GitHub.Behaviour do
  alias GitExplorer.Error

  @callback get_user_repos(String.t()) :: {:ok, list(map())} | {:error, Error.t()}
end
