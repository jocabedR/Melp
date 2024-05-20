defmodule MelpWeb.RestaurantJSON do
  alias Melp.MelpService.Restaurant

  @doc """
  Renders a list of restaurants.
  """
  def index(%{restaurants: restaurants}) do
    %{data: for(restaurant <- restaurants, do: data(restaurant))}
  end

  def statistics(%{count: count, avg: avg, std: std}) do
    %{count: count, avg: avg, std: std}
  end

  @doc """
  Renders a single restaurant.
  """
  def show(%{restaurant: restaurant}) do
    %{data: data(restaurant)}
  end

  defp data(%Restaurant{} = restaurant) do
    %{
      id: restaurant.id,
      rating: restaurant.rating,
      name: restaurant.name,
      site: restaurant.site,
      email: restaurant.email,
      phone: restaurant.phone,
      street: restaurant.street,
      city: restaurant.city,
      state: restaurant.state,
      lat: restaurant.lat,
      lng: restaurant.lng
    }
  end
end
