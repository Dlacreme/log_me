defmodule LogMe.Repo do
  use Ecto.Repo,
    otp_app: :log_me,
    adapter: Ecto.Adapters.Postgres
end
