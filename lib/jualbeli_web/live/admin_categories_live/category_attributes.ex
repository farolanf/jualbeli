defmodule JualbeliWeb.AdminCategoriesLive.CategoryAttributes do
  use JualbeliWeb, :live_component
  alias Jualbeli.Catalog

  attr :class, :any, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={"category-attributes#{if @id, do: "-#{@id}", else: ""}"}
      class={@class}
    >
      <label class="text-sm font-bold">Attributes</label>
      <.attribute_item :for={attr <- @attributes} attribute={attr} />
    </div>
    """
  end

  def attribute_item(assigns) do
    ~H"""
    <div><%= @attribute.label %></div>
    """
  end

  def update(assigns, socket) do
    attributes = Catalog.list_categories_attributes(assigns[:category_id])
    socket = socket
      |> assign(attributes: attributes)
      |> assign(assigns)
    {:ok, socket}
  end
end
