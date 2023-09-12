defmodule Jualbeli.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.Category

  schema "categories" do
    field :title, :string
    belongs_to :parent, Category

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
