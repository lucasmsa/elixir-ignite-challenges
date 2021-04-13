defmodule GithubConsumer.Api.ClientTest do
  use ExUnit.Case, async: true
  alias Plug.Conn
  alias GithubConsumer.Api.Client, as: GithubClient

  describe "get_user_repo_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "If the username exists on github, returns the user's repositories", %{bypass: bypass} do
      username = "lucasmsa"
      url = endpoint_url(bypass.port)

      body = ~s([{
          "id": 297802667,
          "node_id": "MDEwOlJlcG9zaXRvcnkyOTc4MDI2Njc=",
          "name": "algo-expert",
          "html_url": "https://github.com/lucasmsa/algo-expert",
          "description": "Collection of my answers from AlgoExpert interview questions ordered by category 🗿",
          "url": "https://api.github.com/repos/lucasmsa/algo-expert",
          "stargazers_count": 1,
          "watchers_count": 1,
          "language": "TypeScript"
        }
        ])

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = GithubClient.get_user_repo_info(url, username)

      expected_response =
        {:ok,
         [
           %{
             "description" =>
               "Collection of my answers from AlgoExpert interview questions ordered by category 🗿",
             "html_url" => "https://github.com/lucasmsa/algo-expert",
             "id" => 297_802_667,
             "name" => "algo-expert",
             "stargazers_count" => 1
           }
         ]}

      assert expected_response == response
    end

    test "If the user doesn't exist, returns an error", %{bypass: bypass} do
      username = "IDoNotExist"

      body = ~s({
        "message": "Not Found",
        "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      })

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      response = GithubClient.get_user_repo_info(url, username)
      expected_response = {:error, "User could not be found!"}

      assert expected_response == response
    end

    test "If the server is down, returns connection refused error", %{bypass: bypass} do
      username = "IMayExist"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = GithubClient.get_user_repo_info(url, username)
      expected_response = {:error, :econnrefused}

      assert expected_response == response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
