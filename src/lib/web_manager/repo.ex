defmodule WebManager.Repo do
  use Ecto.Repo,
    otp_app: :web_manager,
    adapter: Ecto.Adapters.Postgres
end
