defmodule EctoTestWeb.AddressJSON do
  alias EctoTest.Retail.Address

  @doc """
  Renders a list of addresses.
  """
  def index(%{addresses: addresses}) do
    %{data: for(address <- addresses, do: data(address))}
  end

  @doc """
  Renders a single address.
  """
  def show(%{address: address}) do
    %{data: data(address)}
  end

  defp data(%Address{} = address) do
    %{
      id: address.id,
      city: address.city
    }
  end
end
