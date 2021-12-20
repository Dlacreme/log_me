defmodule LogMeWeb.API do
  @moduledoc """
  For now, the API only allow to push new logs to our system.
  """

  def get_key(), do: Application.fetch_env!(:log_me, :api_key)
end
