defmodule Jualbeli.Repo.Migrations.CreateProductsAttributes do
  use Ecto.Migration

  def change do
    create table(:products_attributes) do
      add :value, :string
      add :product_id, references(:products, on_delete: :delete_all)
      add :attribute_id, references(:attributes, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:products_attributes, [:product_id, :attribute_id])
  end
end
