defmodule BlogApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :type, :string
      add :value, :text
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contacts, [:users_id])
  end
end
