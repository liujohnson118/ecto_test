defmodule EctoTestWeb.ShopJSON do
  alias EctoTest.Retail.Shop

  @doc """
  Renders a list of shops.
  """
  def index(%{shops: shops}) do
    %{data: for(shop <- shops, do: data(shop))}
  end

  @doc """
  Renders a single shop.
  """
  def show(%{shop: shop}) do
    %{data: data(shop)}
  end

  defp data(%Shop{} = shop) do
    %{
      id: shop.id,
      name: shop.name
    }
  end
end
