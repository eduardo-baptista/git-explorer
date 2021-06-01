defmodule GitExplorer.GitHub.ClientTest do
  use ExUnit.Case, async: true

  alias GitExplorer.Error
  alias GitExplorer.GitHub.Client
  alias Plug.Conn

  describe "get_user_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid user, returns the repos", %{bypass: bypass} do
      # Arrange
      user = "github-user"
      url = endpoint_url(bypass.port)

      body =
        ~s({"id":320950618,"node_id":"MDEwOlJlcG9zaXRvcnkzMjA5NTA2MTg=","name":"conference-planner"})

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      # Act
      response = Client.get_user_repos(url, user)

      # Assert
      expected_response =
        {:ok,
         %{
           "id" => 320_950_618,
           "name" => "conference-planner",
           "node_id" => "MDEwOlJlcG9zaXRvcnkzMjA5NTA2MTg="
         }}

      assert response == expected_response
    end

    test "when user not found, returns an error", %{bypass: bypass} do
      # Arrange
      user = "github-user"
      url = endpoint_url(bypass.port)

      body = ""

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        conn
        |> Conn.resp(404, body)
      end)

      # Act
      response = Client.get_user_repos(url, user)

      # Assert
      expected_response = {:error, %Error{reason: "User not found", status: :not_found}}

      assert response == expected_response
    end

    test "when origin fail the request, returns an error", %{bypass: bypass} do
      # Arrange
      user = "github-user"
      url = endpoint_url(bypass.port)

      body = ""

      Bypass.expect(bypass, "GET", "users/#{user}/repos", fn conn ->
        conn
        |> Conn.resp(500, body)
      end)

      # Act
      response = Client.get_user_repos(url, user)

      # Assert
      expected_response = {:error, %Error{reason: "Error during request", status: :bad_request}}

      assert response == expected_response
    end

    test "when request fail, returns an error", %{bypass: bypass} do
      # Arrange
      user = "github-user"
      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      # Act
      response = Client.get_user_repos(url, user)

      # Assert
      expected_response = {:error, %Error{reason: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
