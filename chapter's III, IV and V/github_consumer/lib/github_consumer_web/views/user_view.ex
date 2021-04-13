defmodule GithubConsumerWeb.UsersView do
  use GithubConsumerWeb, :view

  def render("created.json", %{user: user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
