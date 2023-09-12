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

  describe "categories" do
    alias Jualbeli.Catalog.Category

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{title: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Catalog.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Catalog.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Category{} = category} = Catalog.create_category(valid_attrs)
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Category{} = category} = Catalog.update_category(category, update_attrs)
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_category(category, @invalid_attrs)
      assert category == Catalog.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Catalog.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Catalog.change_category(category)
    end
  end

  describe "attributes" do
    alias Jualbeli.Catalog.Attribute

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{label: nil, type: nil}

    test "list_attributes/0 returns all attributes" do
      attribute = attribute_fixture()
      assert Catalog.list_attributes() == [attribute]
    end

    test "get_attribute!/1 returns the attribute with given id" do
      attribute = attribute_fixture()
      assert Catalog.get_attribute!(attribute.id) == attribute
    end

    test "create_attribute/1 with valid data creates a attribute" do
      valid_attrs = %{label: "some label", type: "some type"}

      assert {:ok, %Attribute{} = attribute} = Catalog.create_attribute(valid_attrs)
      assert attribute.label == "some label"
      assert attribute.type == "some type"
    end

    test "create_attribute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_attribute(@invalid_attrs)
    end

    test "update_attribute/2 with valid data updates the attribute" do
      attribute = attribute_fixture()
      update_attrs = %{label: "some updated label", type: "some updated type"}

      assert {:ok, %Attribute{} = attribute} = Catalog.update_attribute(attribute, update_attrs)
      assert attribute.label == "some updated label"
      assert attribute.type == "some updated type"
    end

    test "update_attribute/2 with invalid data returns error changeset" do
      attribute = attribute_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_attribute(attribute, @invalid_attrs)
      assert attribute == Catalog.get_attribute!(attribute.id)
    end

    test "delete_attribute/1 deletes the attribute" do
      attribute = attribute_fixture()
      assert {:ok, %Attribute{}} = Catalog.delete_attribute(attribute)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_attribute!(attribute.id) end
    end

    test "change_attribute/1 returns a attribute changeset" do
      attribute = attribute_fixture()
      assert %Ecto.Changeset{} = Catalog.change_attribute(attribute)
    end
  end

  describe "categories_attributes" do
    alias Jualbeli.Catalog.CategoryAttribute

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{}

    test "list_categories_attributes/0 returns all categories_attributes" do
      category_attribute = category_attribute_fixture()
      assert Catalog.list_categories_attributes() == [category_attribute]
    end

    test "get_category_attribute!/1 returns the category_attribute with given id" do
      category_attribute = category_attribute_fixture()
      assert Catalog.get_category_attribute!(category_attribute.id) == category_attribute
    end

    test "create_category_attribute/1 with valid data creates a category_attribute" do
      valid_attrs = %{}

      assert {:ok, %CategoryAttribute{} = category_attribute} = Catalog.create_category_attribute(valid_attrs)
    end

    test "create_category_attribute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_category_attribute(@invalid_attrs)
    end

    test "update_category_attribute/2 with valid data updates the category_attribute" do
      category_attribute = category_attribute_fixture()
      update_attrs = %{}

      assert {:ok, %CategoryAttribute{} = category_attribute} = Catalog.update_category_attribute(category_attribute, update_attrs)
    end

    test "update_category_attribute/2 with invalid data returns error changeset" do
      category_attribute = category_attribute_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_category_attribute(category_attribute, @invalid_attrs)
      assert category_attribute == Catalog.get_category_attribute!(category_attribute.id)
    end

    test "delete_category_attribute/1 deletes the category_attribute" do
      category_attribute = category_attribute_fixture()
      assert {:ok, %CategoryAttribute{}} = Catalog.delete_category_attribute(category_attribute)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_category_attribute!(category_attribute.id) end
    end

    test "change_category_attribute/1 returns a category_attribute changeset" do
      category_attribute = category_attribute_fixture()
      assert %Ecto.Changeset{} = Catalog.change_category_attribute(category_attribute)
    end
  end

  describe "products_attributes" do
    alias Jualbeli.Catalog.ProductAttribute

    import Jualbeli.CatalogFixtures

    @invalid_attrs %{value: nil}

    test "list_products_attributes/0 returns all products_attributes" do
      product_attribute = product_attribute_fixture()
      assert Catalog.list_products_attributes() == [product_attribute]
    end

    test "get_product_attribute!/1 returns the product_attribute with given id" do
      product_attribute = product_attribute_fixture()
      assert Catalog.get_product_attribute!(product_attribute.id) == product_attribute
    end

    test "create_product_attribute/1 with valid data creates a product_attribute" do
      valid_attrs = %{value: "some value"}

      assert {:ok, %ProductAttribute{} = product_attribute} = Catalog.create_product_attribute(valid_attrs)
      assert product_attribute.value == "some value"
    end

    test "create_product_attribute/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product_attribute(@invalid_attrs)
    end

    test "update_product_attribute/2 with valid data updates the product_attribute" do
      product_attribute = product_attribute_fixture()
      update_attrs = %{value: "some updated value"}

      assert {:ok, %ProductAttribute{} = product_attribute} = Catalog.update_product_attribute(product_attribute, update_attrs)
      assert product_attribute.value == "some updated value"
    end

    test "update_product_attribute/2 with invalid data returns error changeset" do
      product_attribute = product_attribute_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product_attribute(product_attribute, @invalid_attrs)
      assert product_attribute == Catalog.get_product_attribute!(product_attribute.id)
    end

    test "delete_product_attribute/1 deletes the product_attribute" do
      product_attribute = product_attribute_fixture()
      assert {:ok, %ProductAttribute{}} = Catalog.delete_product_attribute(product_attribute)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product_attribute!(product_attribute.id) end
    end

    test "change_product_attribute/1 returns a product_attribute changeset" do
      product_attribute = product_attribute_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product_attribute(product_attribute)
    end
  end
end
