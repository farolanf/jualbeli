defmodule Jualbeli.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string
      add :parent_id, references(:categories, on_delete: :restrict)

      timestamps()
    end

    create index(:categories, [:parent_id])
  end
end
