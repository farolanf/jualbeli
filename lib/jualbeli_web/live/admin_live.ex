defmodule JualbeliWeb.AdminLive do
  use JualbeliWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Admin
    </.header>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
