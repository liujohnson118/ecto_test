defmodule EctoTestWeb.ShopView do
  use EctoTestWeb, :view
  alias EctoTestWeb.ShopView

  def render("index.json", %{shops: shops}) do
    %{data: render_many(shops, ShopView, "shop.json")}
  end

  def render("show.json", %{shop: shop}) do
    %{data: render_one(shop, ShopView, "shop.json")}
  end

  def render("shop.json", %{shop: shop}) do
    shop_return = %{id: shop.id, name: shop.name}

    if Ecto.assoc_loaded?(shop, :address) do
      shop_return = Map.put(shop_return, :address, render_one(shop.address, AddressView, "address.json"))
    end

    shop_return
  end
end
