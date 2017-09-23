defmodule BlogApp.Accounts.UserResolver do
  alias BlogApp.{Accounts.User, User.Contact, Repo}

  def find(%{id: id}, _info) do
    case Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def find(_args, _info) do
    {:ok, Repo.all(User)}
  end

  def create(args, _info) do
    {contact_args, user_args} = Map.pop(args, :contact)

    with {:ok, contact} <- create_contact(contact_args),
    {:ok, user} <- create_user(user_args, contact) do
      {:ok, %{user | contact: contact}}
    end
  end

  defp create_contact(args) do
    %{type: type, value: value} = args
    new_contact = %{type: Atom.to_string(type), value: value}

    %Contact{}
    |> Contact.changeset(new_contact)
    |> Repo.insert
  end

  defp create_user(args, contact) do
    %User{}
    |> Map.put(:contact_id, contact.id)
    |> User.changeset(args)
    |> Repo.insert
  end
end