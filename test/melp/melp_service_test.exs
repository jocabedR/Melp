defmodule Melp.MelpServiceTest do
  use Melp.DataCase

  alias Melp.MelpService

  describe "restaurants" do
    alias Melp.MelpService.Restaurant

    import Melp.MelpServiceFixtures

    @invalid_attrs %{
      city: nil,
      email: nil,
      lat: nil,
      lng: nil,
      name: nil,
      phone: nil,
      rating: nil,
      site: nil,
      state: nil,
      street: nil
    }

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert MelpService.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert MelpService.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      valid_attrs = %{
        city: "some city",
        email: "some email",
        lat: 120.5,
        lng: 120.5,
        name: "some name",
        phone: "some phone",
        rating: 42,
        site: "some site",
        state: "some state",
        street: "some street"
      }

      assert {:ok, %Restaurant{} = restaurant} = MelpService.create_restaurant(valid_attrs)
      assert restaurant.city == "some city"
      assert restaurant.email == "some email"
      assert restaurant.lat == 120.5
      assert restaurant.lng == 120.5
      assert restaurant.name == "some name"
      assert restaurant.phone == "some phone"
      assert restaurant.rating == 42
      assert restaurant.site == "some site"
      assert restaurant.state == "some state"
      assert restaurant.street == "some street"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MelpService.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()

      update_attrs = %{
        city: "some updated city",
        email: "some updated email",
        lat: 456.7,
        lng: 456.7,
        name: "some updated name",
        phone: "some updated phone",
        rating: 43,
        site: "some updated site",
        state: "some updated state",
        street: "some updated street"
      }

      assert {:ok, %Restaurant{} = restaurant} =
               MelpService.update_restaurant(restaurant, update_attrs)

      assert restaurant.city == "some updated city"
      assert restaurant.email == "some updated email"
      assert restaurant.lat == 456.7
      assert restaurant.lng == 456.7
      assert restaurant.name == "some updated name"
      assert restaurant.phone == "some updated phone"
      assert restaurant.rating == 43
      assert restaurant.site == "some updated site"
      assert restaurant.state == "some updated state"
      assert restaurant.street == "some updated street"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()

      assert {:error, %Ecto.Changeset{}} =
               MelpService.update_restaurant(restaurant, @invalid_attrs)

      assert restaurant == MelpService.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = MelpService.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> MelpService.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = MelpService.change_restaurant(restaurant)
    end
  end
end
