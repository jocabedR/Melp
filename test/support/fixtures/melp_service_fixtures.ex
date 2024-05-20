defmodule Melp.MelpServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Melp.MelpService` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
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
      })
      |> Melp.MelpService.create_restaurant()

    restaurant
  end
end
