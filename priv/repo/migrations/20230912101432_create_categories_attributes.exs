defmodule Jualbeli.Repo.Migrations.CreateCategoriesAttributes do
  use Ecto.Migration

  def change do
    create table(:categories_attributes, primary_key: false) do
      add :category_id, references(:categories, on_delete: :restrict)
      add :attribute_id, references(:attributes, on_delete: :restrict)

      timestamps()
    end

    create unique_index(:categories_attributes, [:category_id, :attribute_id])
  end
end
