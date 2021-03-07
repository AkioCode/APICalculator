defmodule Contai.CalculusTest do
  use Contai.DataCase

  alias Contai.Calculus

  describe "operations" do
    alias Contai.Calculus.Operation

    @valid_attrs %{fst_number: 120.5, result: 120.5, scd_number: 120.5, timestamps: "some timestamps", type: "some type"}
    @update_attrs %{fst_number: 456.7, result: 456.7, scd_number: 456.7, timestamps: "some updated timestamps", type: "some updated type"}
    @invalid_attrs %{fst_number: nil, result: nil, scd_number: nil, timestamps: nil, type: nil}

    def operation_fixture(attrs \\ %{}) do
      {:ok, operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calculus.create_operation()

      operation
    end

    test "list_operations/0 returns all operations" do
      operation = operation_fixture()
      assert Calculus.list_operations() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert Calculus.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      assert {:ok, %Operation{} = operation} = Calculus.create_operation(@valid_attrs)
      assert operation.fst_number == 120.5
      assert operation.result == 120.5
      assert operation.scd_number == 120.5
      assert operation.timestamps == "some timestamps"
      assert operation.type == "some type"
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calculus.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{} = operation} = Calculus.update_operation(operation, @update_attrs)
      assert operation.fst_number == 456.7
      assert operation.result == 456.7
      assert operation.scd_number == 456.7
      assert operation.timestamps == "some updated timestamps"
      assert operation.type == "some updated type"
    end

    test "update_operation/2 with invalid data returns error changeset" do
      operation = operation_fixture()
      assert {:error, %Ecto.Changeset{}} = Calculus.update_operation(operation, @invalid_attrs)
      assert operation == Calculus.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{}} = Calculus.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> Calculus.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset" do
      operation = operation_fixture()
      assert %Ecto.Changeset{} = Calculus.change_operation(operation)
    end
  end
end
