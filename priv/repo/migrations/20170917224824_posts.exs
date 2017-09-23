defmodule BlogApp.Repo.Migrations.Posts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :users_id, references(:users, on_delete: :nothing)
      add :posted_at, :utc_datetime

      timestamps()
    end

    create index(:posts, [:users_id])
  end
end
