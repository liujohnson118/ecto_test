defmodule EctoTest.Retail.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :city, :string
  end

  @doc false
  @available_fields ~w(city)
  def changeset(address, attrs) do
    address
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
