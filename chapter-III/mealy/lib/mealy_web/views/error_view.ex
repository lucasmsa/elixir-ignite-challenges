defmodule MealyWeb.ErrorView do
  use MealyWeb, :view
  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{reason: %Changeset{} = reason}) do
    %{message: translate_errors(reason)}
  end

  def render("error.json", %{reason: reason}) do
    %{message: reason}
  end

  def translate_errors(%Changeset{} = changeset) do
    Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
