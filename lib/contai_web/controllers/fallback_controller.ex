defmodule ContaiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ContaiWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ContaiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ContaiWeb.ErrorView)
    |> render("error.json", result: result)
  end

  # This clause is an example of how to handle resources that cannot be found.
end
