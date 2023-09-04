defmodule Jualbeli.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:attrs) do
      add :label, :string
      add :type, :string

      timestamps()
    end

    create table(:categories) do
      add :title, :string
      add :parent_id, references(:categories)

      timestamps()
    end

    create table(:categories_attrs) do
      add :category_id, references(:categories)
      add :attr_id, references(:attrs)

      timestamps()
    end

    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :decimal
      add :category_id, references(:categories)

      timestamps()
    end

    create table(:products_attrs) do
      add :product_id, references(:products)
      add :attr_id, references(:attrs)
      add :value, :string

      timestamps()
    end
  end
end
