defmodule EctoTest.Retail.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string
    belongs_to :address, EctoTest.Retail.Address
  end

  @doc false
  @available_fields ~w(name)
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:address)
  end
end
