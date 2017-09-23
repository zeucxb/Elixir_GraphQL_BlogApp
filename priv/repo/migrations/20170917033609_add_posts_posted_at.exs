defmodule BlogApp.Repo.Migrations.AddPostsPostedAt do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :posted_at, :utc_datetime
    end
  end
end
