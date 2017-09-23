defmodule BlogApp.UserTest do
  use BlogApp.DataCase

  alias BlogApp.User

  describe "contacts" do
    alias BlogApp.User.Contact

    @valid_attrs %{type: "some type", value: "some value"}
    @update_attrs %{type: "some updated type", value: "some updated value"}
    @invalid_attrs %{type: nil, value: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert User.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert User.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = User.create_contact(@valid_attrs)
      assert contact.type == "some type"
      assert contact.value == "some value"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, contact} = User.update_contact(contact, @update_attrs)
      assert %Contact{} = contact
      assert contact.type == "some updated type"
      assert contact.value == "some updated value"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_contact(contact, @invalid_attrs)
      assert contact == User.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = User.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> User.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = User.change_contact(contact)
    end
  end
end
