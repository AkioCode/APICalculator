defmodule Contai.Operation.Calculus do
  alias Contai.{Repo, Operation}, warn: false

  def call(%{"fst_number" => fst_number, "scd_number" => scd_number, "type" => type} = operation) do

    calculate(fst_number, scd_number, String.to_atom(type))
    |> insert_calculus(operation)
  end

  def calculate(n1, n2, _operation) when not(is_integer(n1) and is_integer(n2)), do: {:error, "Numbers must be integers !"}
  def calculate(n1, n2, :sum), do: n1 + n2
  def calculate(n1, n2, :sub), do: n1 - n2
  def calculate(n1, n2, :div), do: floor(n1/n2)
  def calculate(n1, n2, :mul), do: n1*n2
  def calculate(_n1, _n2, _operation), do: {:error, "Invalid operation !"}

  def insert_calculus({:error, _message} = error, _operation), do: error

  def insert_calculus(value, operation) do
    Map.put(operation, "result", value)
    |> Operation.changeset()
    |> Repo.insert()
  end
end
