defmodule LogMe.Account.Const do
  defmodule TokenType do
    def authorization, do: "authorization"
    def password_recovery, do: "password_recovery"
    def account_validation, do: "account_validation"
  end

  defmodule UserRole do
    def admin, do: "admin"
    def user, do: "user"
  end
end
