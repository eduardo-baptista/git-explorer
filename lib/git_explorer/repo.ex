defmodule GitExplorer.Repo do
  use Ecto.Repo,
    otp_app: :git_explorer,
    adapter: Ecto.Adapters.Postgres
end
