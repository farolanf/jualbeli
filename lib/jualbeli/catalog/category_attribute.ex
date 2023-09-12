defmodule Jualbeli.Catalog.CategoryAttribute do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.{Category, Attribute}

  schema "categories_attributes" do
    belongs_to :category, Category
    belongs_to :attribute, Attribute

    timestamps()
  end

  @doc false
  def changeset(category_attribute, attrs) do
    category_attribute
    |> cast(attrs, [])
    |> validate_required([])
  end
end
