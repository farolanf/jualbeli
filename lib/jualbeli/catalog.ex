defmodule Jualbeli.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Jualbeli.Repo

  alias Jualbeli.Catalog.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Jualbeli.Catalog.Highlight

  @doc """
  Returns the list of highlights.

  ## Examples

      iex> list_highlights()
      [%Highlight{}, ...]

  """
  def list_highlights do
    Repo.all(Highlight)
  end

  @doc """
  Gets a single highlight.

  Raises `Ecto.NoResultsError` if the Highlight does not exist.

  ## Examples

      iex> get_highlight!(123)
      %Highlight{}

      iex> get_highlight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_highlight!(id), do: Repo.get!(Highlight, id)

  @doc """
  Creates a highlight.

  ## Examples

      iex> create_highlight(%{field: value})
      {:ok, %Highlight{}}

      iex> create_highlight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_highlight(attrs \\ %{}) do
    %Highlight{}
    |> Highlight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a highlight.

  ## Examples

      iex> update_highlight(highlight, %{field: new_value})
      {:ok, %Highlight{}}

      iex> update_highlight(highlight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_highlight(%Highlight{} = highlight, attrs) do
    highlight
    |> Highlight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a highlight.

  ## Examples

      iex> delete_highlight(highlight)
      {:ok, %Highlight{}}

      iex> delete_highlight(highlight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_highlight(%Highlight{} = highlight) do
    Repo.delete(highlight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking highlight changes.

  ## Examples

      iex> change_highlight(highlight)
      %Ecto.Changeset{data: %Highlight{}}

  """
  def change_highlight(%Highlight{} = highlight, attrs \\ %{}) do
    Highlight.changeset(highlight, attrs)
  end

  alias Jualbeli.Catalog.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end

  alias Jualbeli.Catalog.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories(opts \\ [roots: false, parent_id: nil, order_by: nil]) do
    q = from c in Category

    q = if opts[:roots] do
      from c in q, where: is_nil(c.parent_id)
    else
      q
    end

    q = if opts[:parent_id] do
      from c in q, where: c.parent_id == ^opts[:parent_id]
    else
      q
    end

    q = if opts[:order_by] do
      from c in q, order_by: c.title
    else
      q
    end

    Repo.all(q)
  end

  def category_ancestors(id, opts \\ [self: false]) do
    initial_query = if opts[:self] do
      from c in Category, where: c.id == ^id
    else
      parent_id = from g in Category, where: g.id == ^id, select: g.parent_id
      from c in Category, where: c.id == subquery(parent_id)
    end

    recursive_query = from c in Category, join: a in "ancestors", on: c.id == a.parent_id

    ancestors = initial_query |> union_all(^recursive_query)

    Category
      |> recursive_ctes(true)
      |> with_cte("ancestors", as: ^ancestors)
      |> join(:inner, [c], a in "ancestors", on: c.id == a.id)
      |> Repo.all()
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias Jualbeli.Catalog.Attribute

  @doc """
  Returns the list of attributes.

  ## Examples

      iex> list_attributes()
      [%Attribute{}, ...]

  """
  def list_attributes do
    Repo.all(Attribute)
  end

  @doc """
  Gets a single attribute.

  Raises `Ecto.NoResultsError` if the Attribute does not exist.

  ## Examples

      iex> get_attribute!(123)
      %Attribute{}

      iex> get_attribute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_attribute!(id), do: Repo.get!(Attribute, id)

  @doc """
  Creates a attribute.

  ## Examples

      iex> create_attribute(%{field: value})
      {:ok, %Attribute{}}

      iex> create_attribute(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_attribute(attrs \\ %{}) do
    %Attribute{}
    |> Attribute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a attribute.

  ## Examples

      iex> update_attribute(attribute, %{field: new_value})
      {:ok, %Attribute{}}

      iex> update_attribute(attribute, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_attribute(%Attribute{} = attribute, attrs) do
    attribute
    |> Attribute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a attribute.

  ## Examples

      iex> delete_attribute(attribute)
      {:ok, %Attribute{}}

      iex> delete_attribute(attribute)
      {:error, %Ecto.Changeset{}}

  """
  def delete_attribute(%Attribute{} = attribute) do
    Repo.delete(attribute)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attribute changes.

  ## Examples

      iex> change_attribute(attribute)
      %Ecto.Changeset{data: %Attribute{}}

  """
  def change_attribute(%Attribute{} = attribute, attrs \\ %{}) do
    Attribute.changeset(attribute, attrs)
  end

  alias Jualbeli.Catalog.CategoryAttribute

  @doc """
  Returns the list of categories_attributes.

  ## Examples

      iex> list_categories_attributes()
      [%CategoryAttribute{}, ...]

  """
  def list_categories_attributes(opts \\ [category_id: nil]) do
    q = from ca in CategoryAttribute

    q = if opts[:category_id] do
      from ca in q, where: ca.category_id == ^opts[:category_id]
    else
      q
    end

    Repo.all(q)
  end

  @doc """
  Gets a single category_attribute.

  Raises `Ecto.NoResultsError` if the Category attribute does not exist.

  ## Examples

      iex> get_category_attribute!(123)
      %CategoryAttribute{}

      iex> get_category_attribute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category_attribute!(id), do: Repo.get!(CategoryAttribute, id)

  @doc """
  Creates a category_attribute.

  ## Examples

      iex> create_category_attribute(%{field: value})
      {:ok, %CategoryAttribute{}}

      iex> create_category_attribute(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category_attribute(attrs \\ %{}) do
    %CategoryAttribute{}
    |> CategoryAttribute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category_attribute.

  ## Examples

      iex> update_category_attribute(category_attribute, %{field: new_value})
      {:ok, %CategoryAttribute{}}

      iex> update_category_attribute(category_attribute, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category_attribute(%CategoryAttribute{} = category_attribute, attrs) do
    category_attribute
    |> CategoryAttribute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category_attribute.

  ## Examples

      iex> delete_category_attribute(category_attribute)
      {:ok, %CategoryAttribute{}}

      iex> delete_category_attribute(category_attribute)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category_attribute(%CategoryAttribute{} = category_attribute) do
    q = from ca in CategoryAttribute, where: ca.category_id == ^category_attribute.category_id and ca.attribute_id == ^category_attribute.attribute_id
    Repo.delete_all(q)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category_attribute changes.

  ## Examples

      iex> change_category_attribute(category_attribute)
      %Ecto.Changeset{data: %CategoryAttribute{}}

  """
  def change_category_attribute(%CategoryAttribute{} = category_attribute, attrs \\ %{}) do
    CategoryAttribute.changeset(category_attribute, attrs)
  end

  alias Jualbeli.Catalog.ProductAttribute

  @doc """
  Returns the list of products_attributes.

  ## Examples

      iex> list_products_attributes()
      [%ProductAttribute{}, ...]

  """
  def list_products_attributes do
    Repo.all(ProductAttribute)
  end

  @doc """
  Gets a single product_attribute.

  Raises `Ecto.NoResultsError` if the Product attribute does not exist.

  ## Examples

      iex> get_product_attribute!(123)
      %ProductAttribute{}

      iex> get_product_attribute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_attribute!(id), do: Repo.get!(ProductAttribute, id)

  @doc """
  Creates a product_attribute.

  ## Examples

      iex> create_product_attribute(%{field: value})
      {:ok, %ProductAttribute{}}

      iex> create_product_attribute(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_attribute(attrs \\ %{}) do
    %ProductAttribute{}
    |> ProductAttribute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_attribute.

  ## Examples

      iex> update_product_attribute(product_attribute, %{field: new_value})
      {:ok, %ProductAttribute{}}

      iex> update_product_attribute(product_attribute, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_attribute(%ProductAttribute{} = product_attribute, attrs) do
    product_attribute
    |> ProductAttribute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_attribute.

  ## Examples

      iex> delete_product_attribute(product_attribute)
      {:ok, %ProductAttribute{}}

      iex> delete_product_attribute(product_attribute)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_attribute(%ProductAttribute{} = product_attribute) do
    Repo.delete(product_attribute)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_attribute changes.

  ## Examples

      iex> change_product_attribute(product_attribute)
      %Ecto.Changeset{data: %ProductAttribute{}}

  """
  def change_product_attribute(%ProductAttribute{} = product_attribute, attrs \\ %{}) do
    ProductAttribute.changeset(product_attribute, attrs)
  end
end
