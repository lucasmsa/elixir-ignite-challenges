defmodule GithubConsumerWeb.ClientView do
  use GithubConsumerWeb, :view

  def render("repositories.json", %{repos: repos}) do
    %{
      message: "User found! 🥷🏻",
      repositories: repos
    }
  end
end
