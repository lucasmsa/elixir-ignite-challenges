defmodule GithubConsumerWeb.ClientView do
  use GithubConsumerWeb, :view

  def render("repositories.json", %{repos: repos, refresh_token: refresh_token}) do
    %{
      message: "User found! 🥷🏻",
      refresh_token: refresh_token,
      repositories: repos
    }
  end
end
