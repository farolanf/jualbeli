defmodule JualbeliWeb.AdminLive do
  use JualbeliWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Admin
    </.header>
    <div class="py-8 flex flex-col gap-4">
      <.link href={~p"/admin/categories"}>Categories</.link>
      <.link href={~p"/admin/attributes"}>Attributes</.link>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
