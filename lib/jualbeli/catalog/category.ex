defmodule Jualbeli.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.{Category, Attribute}

  schema "categories" do
    field :title, :string
    belongs_to :parent, Category
    many_to_many :attributes, Attribute, join_through: "categories_attributes"

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :parent_id])
    |> validate_required([:title])
    |> validate_length(:title, min: 2, max: 50)
  end
end
