defmodule Jualbeli.Repo.Migrations.CreateHighlights do
  use Ecto.Migration

  def change do
    create table(:highlights) do
      add :points, :integer
      add :max_points, :integer
      add :point_price, :integer
      add :duration_days, :integer
      add :expired_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:highlights, [:user_id])

    alter table(:products) do
      add :highlight_id, references(:highlights, on_delete: :nilify_all)
    end

    create unique_index(:products, [:highlight_id])
  end
end
