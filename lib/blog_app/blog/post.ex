defmodule BlogApp.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlogApp.Blog.Post


  schema "posts" do
    field :body, :string
    field :title, :string
    field :posted_at, :utc_datetime
    belongs_to :users, BlogApp.Accounts.User, foreign_key: :users_id

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :posted_at])
    |> validate_required([:title, :body, :posted_at])
  end
end
