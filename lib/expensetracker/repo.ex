defmodule Expensetracker.Repo do
  use Ecto.Repo,
    otp_app: :expensetracker,
    adapter: Ecto.Adapters.Postgres
end
