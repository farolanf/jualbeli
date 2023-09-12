defmodule Jualbeli.CatalogTest do
  use Jualbeli.DataCase

  alias Jualbeli.Catalog

  describe "products" do
    alias Jualbeli.Catalog.Product

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{description: nil, price: nil, title: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", price: "120.5", title: "some title"}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.price == Decimal.new("120.5")
      assert product.title == "some title"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{description: "some updated description", price: "456.7", title: "some updated title"}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.price == Decimal.new("456.7")
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end

  describe "highlights" do
    alias Jualbeli.Catalog.Highlight

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{duration_days: nil, expired_at: nil, max_points: nil, point_price: nil, points: nil}

    test "list_highlights/0 returns all highlights" do
      highlight = highlight_fixture()
      assert Catalog.list_highlights() == [highlight]
    end

    test "get_highlight!/1 returns the highlight with given id" do
      highlight = highlight_fixture()
      assert Catalog.get_highlight!(highlight.id) == highlight
    end

    test "create_highlight/1 with valid data creates a highlight" do
      valid_attrs = %{duration_days: 42, expired_at: "some expired_at", max_points: 42, point_price: 42, points: 42}

      assert {:ok, %Highlight{} = highlight} = Catalog.create_highlight(valid_attrs)
      assert highlight.duration_days == 42
      assert highlight.expired_at == "some expired_at"
      assert highlight.max_points == 42
      assert highlight.point_price == 42
      assert highlight.points == 42
    end

    test "create_highlight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_highlight(@invalid_attrs)
    end

    test "update_highlight/2 with valid data updates the highlight" do
      highlight = highlight_fixture()
      update_attrs = %{duration_days: 43, expired_at: "some updated expired_at", max_points: 43, point_price: 43, points: 43}

      assert {:ok, %Highlight{} = highlight} = Catalog.update_highlight(highlight, update_attrs)
      assert highlight.duration_days == 43
      assert highlight.expired_at == "some updated expired_at"
      assert highlight.max_points == 43
      assert highlight.point_price == 43
      assert highlight.points == 43
    end

    test "update_highlight/2 with invalid data returns error changeset" do
      highlight = highlight_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_highlight(highlight, @invalid_attrs)
      assert highlight == Catalog.get_highlight!(highlight.id)
    end

    test "delete_highlight/1 deletes the highlight" do
      highlight = highlight_fixture()
      assert {:ok, %Highlight{}} = Catalog.delete_highlight(highlight)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_highlight!(highlight.id) end
    end

    test "change_highlight/1 returns a highlight changeset" do
      highlight = highlight_fixture()
      assert %Ecto.Changeset{} = Catalog.change_highlight(highlight)
    end
  end

  describe "locations" do
    alias Jualbeli.Catalog.Location

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{lat: nil, lng: nil, loc_type: nil, name: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Catalog.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Catalog.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{lat: "120.5", lng: "120.5", loc_type: "some loc_type", name: "some name"}

      assert {:ok, %Location{} = location} = Catalog.create_location(valid_attrs)
      assert location.lat == Decimal.new("120.5")
      assert location.lng == Decimal.new("120.5")
      assert location.loc_type == "some loc_type"
      assert location.name == "some name"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{lat: "456.7", lng: "456.7", loc_type: "some updated loc_type", name: "some updated name"}

      assert {:ok, %Location{} = location} = Catalog.update_location(location, update_attrs)
      assert location.lat == Decimal.new("456.7")
      assert location.lng == Decimal.new("456.7")
      assert location.loc_type == "some updated loc_type"
      assert location.name == "some updated name"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_location(location, @invalid_attrs)
      assert location == Catalog.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Catalog.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Catalog.change_location(location)
    end
  end
end
