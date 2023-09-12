defmodule Jualbeli.Catalog.Highlight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "highlights" do
    field :duration_days, :integer
    field :expired_at, :string
    field :max_points, :integer
    field :point_price, :integer
    field :points, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(highlight, attrs) do
    highlight
    |> cast(attrs, [:points, :max_points, :point_price, :duration_days, :expired_at])
    |> validate_required([:points, :max_points, :point_price, :duration_days, :expired_at])
  end
end
