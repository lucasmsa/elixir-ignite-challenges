defmodule GithubConsumerWeb.ErrorView do
  use GithubConsumerWeb, :view

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{reason: reason}) do
    %{message: reason}
  end
end
