defmodule Mealy.Repo.Migrations.AddUserIdToMeals do
  use Ecto.Migration

  def change do
    alter table(:meals) do
      add :user_id, references(:users), null: false
    end
  end
end
