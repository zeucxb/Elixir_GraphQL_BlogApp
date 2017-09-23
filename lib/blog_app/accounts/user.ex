defmodule BlogApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlogApp.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    has_many :posts, BlogApp.Blog.Post, foreign_key: :users_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
