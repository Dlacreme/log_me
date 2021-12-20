defmodule LogMeWeb.BaseView do
  defmacro __using__(_) do
    quote do
      use LogMeWeb, :view

      def icon(name), do: content_tag(:i, name, class: "material-icons")
    end
  end
end
