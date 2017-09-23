defmodule BlogApp.Schema do
  use Absinthe.Schema
  import_types BlogApp.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &BlogApp.Blog.PostResolver.all/2
    end

    field :users, list_of(:user) do
      arg :id, :id
      resolve &BlogApp.Accounts.UserResolver.find/2
    end
  end

  mutation do
    field :post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :posted_at, non_null(:time)

      resolve &BlogApp.Blog.PostResolver.create/2
    end

    field :user, :user do
      arg :contact, non_null(:contact_input)
      arg :password, :string

      resolve &BlogApp.Accounts.UserResolver.create/2
    end
  end
end