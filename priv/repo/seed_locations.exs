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

defmodule BpsClient do
  @api_url "https://webapi.bps.go.id/v1/api"
  @key System.get_env("BPS_KEY")

  def get_json(url) do
    url = inject_key(@api_url <> url) |> String.to_charlist()
    {:ok, {{_, 200, _}, _headers, data}} = :httpc.request(url)
    data |> Jason.decode()
  end

  def inject_key(url) do
    uri = URI.parse(url)

    uri = if uri.query do
      query = uri.query
        |> URI.decode_query()
        |> Map.put("key", @key)
        |> URI.encode_query()

      %URI{uri | query: query}
    else
      uri
    end

    URI.to_string(uri)
  end

  def fetch_data() do
    # fetch provinsi

    {:ok, %{"data" => [_, provinces]} = data} = BpsClient.get_json("/domain?type=prov")

    {:ok, str} = data |> Jason.encode()

    :ok = File.write("priv/repo/data/provinsi.json", str)

    # fetch kabupaten

    for prov <- provinces do
      IO.puts(prov["domain_name"])

      {:ok, data} = BpsClient.get_json("/domain?type=kabbyprov&prov=#{prov["domain_id"]}")

      {:ok, str} = data |> Jason.encode()

      :ok = File.write("priv/repo/data/prov_#{prov["domain_id"]}.json", str)

      Process.sleep(500)
    end

  end
end

{:ok, data} = File.read("priv/repo/data/provinsi.json")

{:ok, %{"data" => [_, provinces]}} = Jason.decode(data)

for prov <- provinces do
  {:ok, prov_loc} = Catalog.create_location(%{name: prov["domain_name"], loc_type: "prov", loc_id: prov["domain_id"], lat: 0, lng: 0})

  {:ok, data} = File.read("priv/repo/data/prov_#{prov["domain_id"]}.json")

  {:ok, %{"data" => [_, kabupatens]}} = Jason.decode(data)

  for kab <- kabupatens do
    {:ok, location} = Catalog.create_location(%{name: kab["domain_name"], loc_type: "kab", loc_id: kab["domain_id"], lat: 0, lng: 0, parent_id: prov_loc.id})
  end
end
