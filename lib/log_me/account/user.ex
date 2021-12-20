defmodule LogMe.Account.User do
  alias LogMe.Repo
  alias LogMe.Schemas.Users

  import Ecto.Query, only: [from: 2]

  @spec list() :: list(Users.t())
  def list(),
    do: Repo.all(Users)

  @spec get(Ecto.UUID.t()) :: Users.t() | nil
  def get(id) do
    Repo.one(from u in Users, where: u.id == ^id)
  end

  @spec get_by_email_and_password(String.t(), String.t()) :: Users.t() | nil
  def get_by_email_and_password(email, password) do
    case Repo.get_by(Users, email: email) do
      nil -> nil
      user -> if valid_password?(user, password), do: user, else: nil
    end
  end

  defp valid_password?(%Users{password: hashed_password}, password),
    do: Bcrypt.verify_pass(password, hashed_password)

  defp valid_password?(_u, _p),
    do: false
end
