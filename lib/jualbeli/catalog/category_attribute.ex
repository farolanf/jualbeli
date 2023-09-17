defmodule Jualbeli.Catalog.CategoryAttribute do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.{Category, Attribute}

  @primary_key false

  schema "categories_attributes" do
    belongs_to :category, Category
    belongs_to :attribute, Attribute

    timestamps()
  end

  @doc false
  def changeset(category_attribute, attrs) do
    category_attribute
    |> cast(attrs, [:category_id, :attribute_id])
    |> validate_required([])
  end
end
