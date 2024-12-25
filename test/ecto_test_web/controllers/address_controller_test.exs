defmodule EctoTestWeb.AddressControllerTest do
  use EctoTestWeb.ConnCase

  import EctoTest.RetailFixtures

  alias EctoTest.Retail.Address

  @create_attrs %{
    city: "some city"
  }
  @update_attrs %{
    city: "some updated city"
  }
  @invalid_attrs %{city: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, ~p"/api/addresses")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/addresses", address: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/addresses/#{id}")

      assert %{
               "id" => ^id,
               "city" => "some city"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/addresses", address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put(conn, ~p"/api/addresses/#{address}", address: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/addresses/#{id}")

      assert %{
               "id" => ^id,
               "city" => "some updated city"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put(conn, ~p"/api/addresses/#{address}", address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, ~p"/api/addresses/#{address}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/addresses/#{address}")
      end
    end
  end

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end
end
