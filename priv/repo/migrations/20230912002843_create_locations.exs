defmodule Jualbeli.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :loc_type, :string
      add :loc_id, :string, null: false
      add :lat, :decimal
      add :lng, :decimal
      add :parent_id, references(:locations, on_delete: :restrict)

      timestamps()
    end

    create index(:locations, [:parent_id])
    create index(:locations, [:lat, :lng])
    create unique_index(:locations, [:loc_id])

    alter table(:products) do
      add :location_id, references(:locations, on_delete: :restrict), null: false
      add :lat, :decimal
      add :lng, :decimal
    end

    create index(:products, [:location_id])
    create index(:products, [:lat, :lng])
  end
end
