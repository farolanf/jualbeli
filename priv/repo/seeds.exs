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

alias Jualbeli.Accounts

Accounts.register_user(%{email: "admin@jb.farol.dev", password: System.fetch_env!("PASSWORD")})
