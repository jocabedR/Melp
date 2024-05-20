defmodule MelpWeb.RestaurantController do
  use MelpWeb, :controller

  alias Melp.MelpService
  alias Melp.MelpService.Restaurant

  action_fallback MelpWeb.FallbackController

  def index(conn, _params) do
    restaurants = MelpService.list_restaurants()
    render(conn, :index, restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- MelpService.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/restaurants/#{restaurant}")
      |> render(:show, restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = MelpService.get_restaurant!(id)
    render(conn, :show, restaurant: restaurant)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = MelpService.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <-
           MelpService.update_restaurant(restaurant, restaurant_params) do
      render(conn, :show, restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = MelpService.get_restaurant!(id)

    with {:ok, %Restaurant{}} <- MelpService.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end

  def statistics(conn, %{"latitude" => lat, "longitude" => lng, "radius" => radius}) do
    with {lat, _} <- Float.parse(lat),
         {lng, _} <- Float.parse(lng),
         {radius, _} <- Float.parse(radius) do
      restaurants = MelpService.statistics(lat, lng, radius)

      count = length(restaurants)
      avg = restaurants |> Enum.map(& &1.rating) |> mean()
      std = restaurants |> Enum.map(& &1.rating) |> standard_deviation()

      render(conn, :statistics, count: count, avg: avg, std: std)
    else
      _ -> {:error, "Bad request"}
    end
  end

  defp standard_deviation(data) do
    m = mean(data)
    data |> variance(m) |> mean |> :math.sqrt()
  end

  defp mean(data) do
    Enum.sum(data) / length(data)
  end

  defp variance(data, mean) do
    for n <- data, do: :math.pow(n - mean, 2)
  end
end
