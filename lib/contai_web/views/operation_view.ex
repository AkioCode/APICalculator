defmodule ContaiWeb.OperationView do
  use ContaiWeb, :view
  alias ContaiWeb.OperationView

  def render("index.json", %{operations: operations}) do
    %{data: render_many(operations, OperationView, "operation.json")}
  end

  def render("show.json", %{operation: operation}) do
    %{data: render_one(operation, OperationView, "operation.json")}
  end

  def render("operation.json", %{operation: operation}) do
    %{
      id: operation.id,
      type: operation.type,
      fst_number: operation.fst_number,
      scd_number: operation.scd_number,
      result: operation.result,
      inserted_at: operation.inserted_at,
      updated_at: operation.updated_at
    }
  end
end
