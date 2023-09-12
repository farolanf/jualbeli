defmodule Jualbeli.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jualbeli.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        price: "120.5",
        title: "some title"
      })
      |> Jualbeli.Catalog.create_product()

    product
  end

  @doc """
  Generate a highlight.
  """
  def highlight_fixture(attrs \\ %{}) do
    {:ok, highlight} =
      attrs
      |> Enum.into(%{
        duration_days: 42,
        expired_at: "some expired_at",
        max_points: 42,
        point_price: 42,
        points: 42
      })
      |> Jualbeli.Catalog.create_highlight()

    highlight
  end

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        lat: "120.5",
        lng: "120.5",
        loc_type: "some loc_type",
        name: "some name"
      })
      |> Jualbeli.Catalog.create_location()

    location
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Jualbeli.Catalog.create_category()

    category
  end

  @doc """
  Generate a attribute.
  """
  def attribute_fixture(attrs \\ %{}) do
    {:ok, attribute} =
      attrs
      |> Enum.into(%{
        label: "some label",
        type: "some type"
      })
      |> Jualbeli.Catalog.create_attribute()

    attribute
  end

  @doc """
  Generate a category_attribute.
  """
  def category_attribute_fixture(attrs \\ %{}) do
    {:ok, category_attribute} =
      attrs
      |> Enum.into(%{

      })
      |> Jualbeli.Catalog.create_category_attribute()

    category_attribute
  end

  @doc """
  Generate a product_attribute.
  """
  def product_attribute_fixture(attrs \\ %{}) do
    {:ok, product_attribute} =
      attrs
      |> Enum.into(%{
        value: "some value"
      })
      |> Jualbeli.Catalog.create_product_attribute()

    product_attribute
  end
end
