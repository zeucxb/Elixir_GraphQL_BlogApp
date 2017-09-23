defmodule BlogApp.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: BlogApp.Repo

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    #
    # Take note on the names here:
    # list_of(:blog_post) -> :blog_post maps to the Absinthe object down below
    # while assoc(:blog_posts) maps to the table!
    # The table names are named that because of Phoenix contexts that we made earlier!
    #
    field :posts, list_of(:post), resolve: assoc(:posts)
  end

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :posted_at, :string
    #
    # You can see the same pattern here:
    # field :user, :accounts_user -> :accounts_user = the object above
    # assoc(:accounts_users) -> :accounts_users = the accounts_users table
    #
    field :user, :user, resolve: assoc(:users)
  end

  scalar :time, description: "ISOz time" do
    parse &Timex.Parse.DateTime.Parser.parse(&1.value, "{ISO:Extended}")
    serialize &Timex.Format.DateTime.Formatter.format(&1, "{ISO:Extended}")
  end

  enum :contact_type do
    value :phone
    value :email
  end

  input_object :contact_input do
    field :type, non_null(:contact_type)
    field :value, non_null(:string)
  end
end