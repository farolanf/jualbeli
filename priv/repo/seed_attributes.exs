# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jualbeli.Repo.insert!(%Jualbeli.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query
alias Jualbeli.Repo
alias Jualbeli.Catalog

{:ok, %{"attributes" => attributes}} = YamlElixir.read_from_file("priv/repo/data/attributes.yml")

for attr <- attributes do
  Catalog.create_attribute(%{label: attr["name"], type: attr["type"]})
end
