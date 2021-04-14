defmodule GithubConsumerWeb.UsersView do
  use GithubConsumerWeb, :view

  def render("created.json", %{user: user, token: token}) do
    %{
      message: "User created!",
      user: user,
      token: token
    }
  end

  def render("user.json", %{user: user}) do
    %{
      user: user
    }
  end

  def render("signin.json", %{user: user, token: token}) do
    %{
      user: user,
      token: token
    }
  end
end
