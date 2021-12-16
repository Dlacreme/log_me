defmodule LogMe.Account.Token do
  @moduledoc """
  Generates, Parse & validated all tokens used within LogMe
  """
  alias LogMe.Schemas.Users
  alias LogMe.Account.Const.TokenType
  alias LogMe.Schemas.Tokens
  alias LogMe.Repo

  import Ecto.Query, only: [from: 2]

  defmodule JWT do
    @moduledoc """
    Allow to create an handle JWT - see Joken for more details
    """
    use Joken.Config

    @impl true
    def token_config do
      default_claims(skip: [:exp])
      |> add_claim("exp", fn -> Joken.current_time() + 24 * 60 * 60 end, fn val, _, _ ->
        val < Joken.current_time()
      end)
    end
  end

  @spec get(String.t()) :: %Tokens{} | nil
  def get(id) do
    d = NaiveDateTime.utc_now()

    Repo.one(
      from t in Tokens,
        where: t.id == ^id and t.deprecated_at >= ^d
    )
  end

  @spec get_by_token(String.t(), boolean()) :: %Tokens{} | nil
  def get_by_token(token, allow_deprecated \\ false) do
    case Repo.one(from t in Tokens, where: t.token == ^token, limit: 1) do
      nil ->
        nil

      token ->
        if allow_deprecated || token.deprecated_at >= NaiveDateTime.utc_now(),
          do: token,
          else: nil
    end
  end

  @spec account_validation(%Users{}) :: {:ok, %Tokens{}}
  def account_validation(%Users{} = user),
    do: generate(user.id, TokenType.account_validation(), 1)

  @spec authorization_code(%Users{}) :: {:ok, %Tokens{}}
  def authorization_code(%Users{} = user),
    do: authorization_code(user.id)

  def authorization_code(user_id), do: generate_jwt(user_id, TokenType.authorization(), 1)

  defp generate_jwt(user_id, type, expire_days) do
    token = JWT.generate_and_sign!(%{})
    generate(user_id, type, expire_days, token)
  end

  defp generate(user_id, type, expire_days) do
    generate(user_id, type, expire_days, sign_token(user_id, type))
  end

  defp generate(user_id, type, expire_days, token) do
    %Tokens{}
    |> Tokens.changeset(%{
      token: token,
      deprecated_at:
        NaiveDateTime.add(
          NaiveDateTime.utc_now(),
          expire_days * 24 * 60 * 60,
          :second
        ),
      user_id: user_id,
      type_id: type
    })
    |> Repo.insert()
  end

  defp sign_token(user_id, type), do: Phoenix.Token.sign(LogMeWeb.Endpoint, type, user_id)
end
