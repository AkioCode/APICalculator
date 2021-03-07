defmodule ContaiWeb.OperationControllerTest do
  use ContaiWeb.ConnCase

  alias Contai.Calculus
  alias Contai.Calculus.Operation

  @create_attrs %{
    fst_number: 120.5,
    result: 120.5,
    scd_number: 120.5,
    timestamps: "some timestamps",
    type: "some type"
  }
  @update_attrs %{
    fst_number: 456.7,
    result: 456.7,
    scd_number: 456.7,
    timestamps: "some updated timestamps",
    type: "some updated type"
  }
  @invalid_attrs %{fst_number: nil, result: nil, scd_number: nil, timestamps: nil, type: nil}

  def fixture(:operation) do
    {:ok, operation} = Calculus.create_operation(@create_attrs)
    operation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all operations", %{conn: conn} do
      conn = get(conn, Routes.operation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create operation" do
    test "renders operation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.operation_path(conn, :create), operation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.operation_path(conn, :show, id))

      assert %{
               "id" => id,
               "fst_number" => 120.5,
               "result" => 120.5,
               "scd_number" => 120.5,
               "timestamps" => "some timestamps",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.operation_path(conn, :create), operation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update operation" do
    setup [:create_operation]

    test "renders operation when data is valid", %{conn: conn, operation: %Operation{id: id} = operation} do
      conn = put(conn, Routes.operation_path(conn, :update, operation), operation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.operation_path(conn, :show, id))

      assert %{
               "id" => id,
               "fst_number" => 456.7,
               "result" => 456.7,
               "scd_number" => 456.7,
               "timestamps" => "some updated timestamps",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, operation: operation} do
      conn = put(conn, Routes.operation_path(conn, :update, operation), operation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete operation" do
    setup [:create_operation]

    test "deletes chosen operation", %{conn: conn, operation: operation} do
      conn = delete(conn, Routes.operation_path(conn, :delete, operation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.operation_path(conn, :show, operation))
      end
    end
  end

  defp create_operation(_) do
    operation = fixture(:operation)
    %{operation: operation}
  end
end
