defmodule BlogApp.User.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias BlogApp.User.Contact


  schema "contacts" do
    field :type, :string
    field :value, :string
    belongs_to :users, BlogApp.Accounts.User, foreign_key: :users_id

    timestamps()
  end

  @doc false
  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
