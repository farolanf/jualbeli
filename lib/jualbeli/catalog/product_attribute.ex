defmodule Jualbeli.Catalog.ProductAttribute do
  alias Jualbeli.Catalog.Product
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.{Product, Attribute}

  schema "products_attributes" do
    field :value, :string
    belongs_to :product, Product
    belongs_to :attribute, Attribute

    timestamps()
  end

  @doc false
  def changeset(product_attribute, attrs) do
    product_attribute
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
