defmodule ContaiWeb.OperationController do
  import Plug.Conn.Status, only: [code: 1]
  use PhoenixSwagger
  use ContaiWeb, :controller

  alias Contai.{Operation, Repo}
  alias Contai.Operation.Calculus
  alias ContaiWeb.FallbackController

  action_fallback ContaiWeb.FallbackController

  swagger_path :index do
    get("/operations")
    description("List of operations calculated")
    response(code(:ok), "Success")
    tag "Operations"
  end
  swagger_path :sum do
    post("/operations/sum")
    produces "application/json"
    tag "Operations"
    parameters do
      fst_number :path, :integer,   "First number of operation", required: true
      scd_number :query, :integer,  "Second number of operation", required: true
    end
    description("Sum operation")
    response 200, "OK", Schema.ref(:Operations)
    response 422, "Unprocessable Entity"
  end
  swagger_path :sub do
    post("/operations/sub")
    produces "application/json"
    tag "Operations"
    parameters do
      fst_number :path, :integer,   "First number of operation", required: true
      scd_number :query, :integer,  "Second number of operation", required: true
    end
    description("Subtraction operation")
    response 200, "OK", Schema.ref(:Operations)
    response 422, "Unprocessable Entity"
  end
  swagger_path :div do
    post("/operations/div")
    produces "application/json"
    tag "Operations"
    parameters do
      fst_number :path, :integer,   "First number of operation", required: true
      scd_number :query, :integer,  "Second number of operation", required: true
    end
    description("Division operation")
    response 200, "OK", Schema.ref(:Operations)
    response 422, "Unprocessable Entity"
  end
  swagger_path :mul do
    post("/operations/mul")
    produces "application/json"
    tag "Operations"
    parameters do
      fst_number :path, :integer,   "First number of operation", required: true
      scd_number :query, :integer,  "Second number of operation", required: true
    end
    description("Multiplication operation")
    response 200, "OK", Schema.ref(:Operations)
    response 422, "Unprocessable Entity"
  end

  def index(conn, _params) do
    operations = Repo.all(Operation)
    conn
    |> put_status(:ok)
    |> render("index.json", operations: operations)
  end

  def sum(conn, params) do
    params = Map.put(params, "type", "sum")
    with {:ok, %Operation{} = operation} <- Calculus.call(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", operation: operation)
    end
  end
  def sub(conn, params) do
    params =  Map.put(params, "type", "sub")
    with {:ok, %Operation{} = operation} <- Calculus.call(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", operation: operation)
    end
  end
  def div(conn, params) do
    params =  Map.put(params, "type", "div")
    Map.put(params, "type", "div")
    if ({:ok, 0} == Map.fetch(params, "scd_number")) do
      FallbackController.call(conn, {:error, "Division by zero."})
    else
      with {:ok, %Operation{} = operation} <- Calculus.call(params) do
        conn
        |> put_status(:ok)
        |> render("show.json", operation: operation)
      end
    end
  end
  def mul(conn, params) do
    params =  Map.put(params, "type", "mul")
    with {:ok, %Operation{} = operation} <- Calculus.call(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", operation: operation)
    end
  end
end
