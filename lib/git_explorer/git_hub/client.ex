defmodule GitExplorer.GitHub.Client do
  use Tesla

  alias GitExplorer.Error
  alias Tesla.Env

  @base_url "https://api.github.com/"
  plug Tesla.Middleware.JSON

  @behaviour GitExplorer.GitHub.Behaviour

  def get_user_repos(base_url \\ @base_url, user) do
    "#{base_url}users/#{user}/repos"
    |> get()
    |> handle_get()
  end

  def handle_get({:ok, %Env{status: 404}}) do
    {:error, %Error{reason: "User not found", status: :not_found}}
  end

  def handle_get({:ok, %Env{status: status}}) when status >= 300 do
    {:error, %Error{reason: "Error during request", status: :bad_request}}
  end

  def handle_get({:ok, %Env{body: body}}), do: {:ok, body}

  def handle_get({:error, reason}) do
    {:error, %Error{reason: reason, status: :bad_request}}
  end
end
