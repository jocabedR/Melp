defmodule Melp.CSVImport do
  @moduledoc """
  Module to import CVS data into restaurat restaurant table.
  """
  alias Melp.Repo
  alias Melp.MelpService.Restaurant
  require Logger
  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  @doc """
  Function get, decode and insert all CSV information into restaurant.
  """
  def import_csv(file_path) do
    file_path
    |> File.stream!()
    |> MyParser.parse_stream()
    |> Stream.each(&insert_restaurant/1)
    |> Stream.run()
  end

  @doc """
  Function to insert a restaurant on restaurant table.
  """
  defp insert_restaurant([id, rating, name, site, email, phone, street, city, state, lat, lng]) do
    %Restaurant{}
    |> Restaurant.changeset(%{
      id: id,
      rating: rating,
      name: name,
      site: site,
      email: email,
      phone: phone,
      street: street,
      city: city,
      state: state,
      lat: lat,
      lng: lng
    })
    |> Repo.insert()
    |> case do
      {:ok, _usuario} ->
        Logger.info("Restaurant #{name} was inserted.")

      {:error, changeset} ->
        Logger.error("Error when inserting restaurant#{name}: #{inspect(changeset)}")
    end
  end
end
