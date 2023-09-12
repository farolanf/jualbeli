defmodule JualbeliWeb.AdminCategoriesLive do
  use JualbeliWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Categories
    </.header>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
