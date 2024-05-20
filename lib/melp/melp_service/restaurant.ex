defmodule Melp.MelpService.Restaurant do
  @moduledoc """
  Ecto Restaurant Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  schema "restaurants" do
    field :city, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :phone, :string
    field :rating, :integer
    field :site, :string
    field :state, :string
    field :street, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [
      :id,
      :rating,
      :name,
      :site,
      :email,
      :phone,
      :street,
      :city,
      :state,
      :lat,
      :lng
    ])
    |> validate_required([
      :id,
      :rating,
      :name,
      :site,
      :email,
      :phone,
      :street,
      :city,
      :state,
      :lat,
      :lng
    ])
  end
end
