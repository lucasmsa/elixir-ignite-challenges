defmodule GithubConsumer do
  alias GithubConsumer.Api.Client, as: GithubClient

  defdelegate get_user_repo_info(username), to: GithubClient, as: :get_user_repo_info
end
