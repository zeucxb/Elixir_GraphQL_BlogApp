defmodule BlogAppWeb.ContactControllerTest do
  use BlogAppWeb.ConnCase

  alias BlogApp.User
  alias BlogApp.User.Contact

  @create_attrs %{type: "some type", value: "some value"}
  @update_attrs %{type: "some updated type", value: "some updated value"}
  @invalid_attrs %{type: nil, value: nil}

  def fixture(:contact) do
    {:ok, contact} = User.create_contact(@create_attrs)
    contact
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contacts", %{conn: conn} do
      conn = get conn, contact_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contact" do
    test "renders contact when data is valid", %{conn: conn} do
      conn = post conn, contact_path(conn, :create), contact: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, contact_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "type" => "some type",
        "value" => "some value"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, contact_path(conn, :create), contact: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contact" do
    setup [:create_contact]

    test "renders contact when data is valid", %{conn: conn, contact: %Contact{id: id} = contact} do
      conn = put conn, contact_path(conn, :update, contact), contact: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, contact_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "type" => "some updated type",
        "value" => "some updated value"}
    end

    test "renders errors when data is invalid", %{conn: conn, contact: contact} do
      conn = put conn, contact_path(conn, :update, contact), contact: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contact" do
    setup [:create_contact]

    test "deletes chosen contact", %{conn: conn, contact: contact} do
      conn = delete conn, contact_path(conn, :delete, contact)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, contact_path(conn, :show, contact)
      end
    end
  end

  defp create_contact(_) do
    contact = fixture(:contact)
    {:ok, contact: contact}
  end
end
