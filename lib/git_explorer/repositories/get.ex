defmodule GitExplorer.Repositories.Get do
  def get_by_user(user) do
    case get_client().get_user_repos(user) do
      {:error, _reason} = error -> error
      {:ok, repos} -> {:ok, format_repos(repos)}
    end
  end

  defp format_repos(repos), do: Enum.map(repos, &format_repo/1)

  defp format_repo(%{
         "id" => id,
         "name" => name,
         "description" => description,
         "html_url" => html_url,
         "stargazers_count" => stargazers_count
       }) do
    %{
      "id" => id,
      "name" => name,
      "description" => description,
      "html_url" => html_url,
      "stargazers_count" => stargazers_count
    }
  end

  defp get_client do
    :git_explorer
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:git_hub_adapter)
  end
end
