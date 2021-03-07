defmodule Contai do
  @moduledoc """
  Contai keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  import Ecto.Query, warn: false

  alias Contai.Operation.{Sum, Sub, Div, Mul}

  defdelegate list_operations(params), to: Sum, as: :call
  defdelegate sum(params), to: Sum, as: :call
  defdelegate sub(params), to: Sub, as: :call
  defdelegate div(conn, params), to: Div, as: :call
  defdelegate mul(params), to: Mul, as: :call
end
