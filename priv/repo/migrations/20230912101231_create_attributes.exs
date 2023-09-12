defmodule Jualbeli.Repo.Migrations.CreateAttributes do
  use Ecto.Migration

  def change do
    create table(:attributes) do
      add :label, :string
      add :type, :string

      timestamps()
    end
  end
end
