defmodule LogMeWeb.BaseView do
  defmacro __using__(_) do
    quote do
      use LogMeWeb, :view
      alias LogMe.Schemas.Users

      def icon(name), do: content_tag(:i, name, class: "material-icons")

      def user_name(%Users{email: email, username: username}) do
        if username != nil && username != "", do: username, else: email
      end
    end
  end
end
