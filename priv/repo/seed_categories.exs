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

#Repo.delete_all(Catalog.CategoryAttribute)
#Repo.delete_all(Catalog.Category)

{:ok, %{"categories" => categories}} = YamlElixir.read_from_file("priv/repo/data/categories.yml")

defmodule SeedCategory do
  def create_category(params) do
    {:ok, category} = Catalog.create_category(%{title: params["name"], parent_id: params["parent_id"]})

    if params["attrs"] do
      for attr <- params["attrs"] do
        %Catalog.Attribute{} = attribute = Repo.one((from a in Catalog.Attribute, where: a.label == ^attr))
        Catalog.create_category_attribute(%{category_id: category.id, attribute_id: attribute.id})
      end
    end

    if params["children"] do
      for child <- params["children"] do
        create_category(child |> Map.put("parent_id", category.id))
      end
    end
  end
end

for category <- categories do
  SeedCategory.create_category(category)
end
