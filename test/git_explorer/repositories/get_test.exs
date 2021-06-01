defmodule GitExplorer.Repositories.GetTest do
  use ExUnit.Case, async: true

  import Mox

  alias GitExplorer.Error
  alias GitExplorer.GitHub.ClientMock
  alias GitExplorer.Repositories.Get

  describe "get_by_user/1" do
    test "When user is valid, returns the repositories" do
      # Arrange
      user = "github_user"

      expect(ClientMock, :get_user_repos, fn _user ->
        {:ok,
         [
           %{
             "description" => nil,
             "html_url" => "https://github.com/eduardo-baptista/reactjs-tdd",
             "id" => 226_430_444,
             "name" => "reactjs-tdd",
             "stargazers_count" => 0,
             "user" => "github_user"
           }
         ]}
      end)

      # Act
      response = Get.get_by_user(user)

      # Assert
      expected_response =
        {:ok,
         [
           %{
             "description" => nil,
             "html_url" => "https://github.com/eduardo-baptista/reactjs-tdd",
             "id" => 226_430_444,
             "name" => "reactjs-tdd",
             "stargazers_count" => 0
           }
         ]}

      assert response == expected_response
    end

    test "When failed to get the repos, returns an error" do
      # Arrange
      user = "github_user"

      expect(ClientMock, :get_user_repos, fn _user ->
        {:error, %Error{reason: "User not found", status: :not_found}}
      end)

      # Act
      response = Get.get_by_user(user)

      # Assert
      expected_response = {:error, %Error{reason: "User not found", status: :not_found}}
      assert response == expected_response
    end
  end
end
