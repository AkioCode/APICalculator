defmodule Contai.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @params [:type, :fst_number, :scd_number, :result]
  @required_params [:type, :fst_number, :scd_number]

  schema "operations" do
    field :fst_number, :integer
    field :result, :integer
    field :scd_number, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @params)
    |> validate_required(@required_params)
    |> check_constraint(:type, name: :ck_type)
  end
end
