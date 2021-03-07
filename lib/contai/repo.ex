defmodule Contai.Repo do
  use Ecto.Repo,
    otp_app: :contai,
    adapter: Ecto.Adapters.Postgres
end
