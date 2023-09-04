defmodule Jualbeli.Repo do
  use Ecto.Repo,
    otp_app: :jualbeli,
    adapter: Ecto.Adapters.SQLite3
end
