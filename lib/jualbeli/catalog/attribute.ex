defmodule Jualbeli.Catalog.Attribute do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attributes" do
    field :label, :string
    field :type, :string
    field :options, :map

    timestamps()
  end

  @doc false
  def changeset(attribute, attrs) do
    attribute
    |> cast(attrs, [:label, :type, :options])
    |> validate_required([:label, :type])
  end
end
