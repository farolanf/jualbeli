defmodule Jualbeli.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :decimal
      add :category_id, references(:categories)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
