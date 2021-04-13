defmodule GithubConsumer do
  alias GithubConsumer.Api.Client, as: GithubClient
  alias GithubConsumer.Users.Create, as: UsersCreate

  defdelegate get_user_repo_info(username), to: GithubClient, as: :get_user_repo_info
  defdelegate create_user(password), to: UsersCreate, as: :call
end
