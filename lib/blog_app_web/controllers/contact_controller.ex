defmodule BlogAppWeb.ContactController do
  use BlogAppWeb, :controller

  alias BlogApp.User
  alias BlogApp.User.Contact

  action_fallback BlogAppWeb.FallbackController

  def index(conn, _params) do
    contacts = User.list_contacts()
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, %{"contact" => contact_params}) do
    with {:ok, %Contact{} = contact} <- User.create_contact(contact_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", contact_path(conn, :show, contact))
      |> render("show.json", contact: contact)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = User.get_contact!(id)
    render(conn, "show.json", contact: contact)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = User.get_contact!(id)

    with {:ok, %Contact{} = contact} <- User.update_contact(contact, contact_params) do
      render(conn, "show.json", contact: contact)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = User.get_contact!(id)
    with {:ok, %Contact{}} <- User.delete_contact(contact) do
      send_resp(conn, :no_content, "")
    end
  end
end
