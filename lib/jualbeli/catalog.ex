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
end
