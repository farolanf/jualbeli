defmodule Jualbeli.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :loc_type, :string
      add :lat, :decimal
      add :lng, :decimal
      add :parent_id, references(:locations, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:parent_id])
    create index(:locations, [:lat, :lng])

    alter table(:products) do
      add :location_id, references(:locations, on_delete: :nilify_all)
      add :lat, :decimal
      add :lng, :decimal
    end

    create index(:products, [:location_id])
    create index(:products, [:lat, :lng])
  end
end
