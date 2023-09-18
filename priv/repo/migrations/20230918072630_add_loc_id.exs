defmodule Jualbeli.Repo.Migrations.AddLocId do
  use Ecto.Migration

  def change do
    alter table(:locations) do
      add :loc_id, :string, null: false
    end
  end
end
