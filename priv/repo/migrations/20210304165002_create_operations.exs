defmodule Contai.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :type, :string
      add :fst_number, :integer
      add :scd_number, :integer
      add :result, :integer
      add :timestamps, :string

      timestamps()
    end

    create constraint(:operations, :ck_type, check: "type in ('sum', 'sub', 'div', 'mul')")
  end
end
