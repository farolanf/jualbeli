defmodule Jualbeli.Repo.Migrations.AddOptionsToAttributes do
  use Ecto.Migration

  def change do
    alter table(:attributes) do
      add :options, :map
    end
  end
end
