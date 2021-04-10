defmodule GithubConsumer.Api.Client do
  use Tesla
  alias Tesla.Env

  @baseUrl "https://api.github.com/users"
  @repository_data ["id", "name", "stargazers_count", "description", "html_url"]

  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Headers, [{"user-agent", "Tesla"}])

  def get_user_repo_info(url \\ @baseUrl, username) do
    "#{url}/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repositories_info =
      Enum.map(body, fn repo ->
        fetch_repo_info(repo)
      end)

    {:ok, repositories_info}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, "User could not be found!"}
  end

  defp fetch_repo_info(repo) do
    :maps.filter(fn key, _value -> key in @repository_data end, repo)
  end
end
