defmodule Jualbeli.Catalog.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jualbeli.Catalog.Location

  schema "locations" do
    field :lat, :decimal
    field :lng, :decimal
    field :loc_type, :string
    field :name, :string
    belongs_to :parent, Location

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :loc_type, :lat, :lng])
    |> validate_required([:name, :loc_type, :lat, :lng])
  end
end
