defmodule MealyWeb.UsersView do
  use MealyWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "User created 🥩",
      user: user
    }
  end

  def render("user.json", %{user: user}) do
    %{
      user: user
    }
  end
end
