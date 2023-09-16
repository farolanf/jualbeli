defmodule JualbeliWeb.AdminAttributesLive do
  use JualbeliWeb, :live_view
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Attribute
  alias JualbeliWeb.AdminAttributesLive.{NewAttributeForm, EditAttributeForm}

  attr :edit_attribute_id, :integer, default: nil
  attr :deleted_attribute_id, :integer, default: nil
  attr :show_new_form, :boolean, default: false

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Attributes
    </.header>
    <div class="space-y-12">
      <div class="flex gap-6">
        <button
          phx-click="show_new_form"
          class="text-xs font-bold text-blue-700"
        >
          New attribute
        </button>
      </div>
      <.live_component
        :if={@show_new_form}
        module={NewAttributeForm}
        id="root"
        form_class="-mt-8"
      />
      <.attribute_list
        id="attributes"
        class=""
        attributes={@attributes}
        edit_attribute_id={@edit_attribute_id}
        deleted_attribute_id={@deleted_attribute_id}
      />
    </div>
    """
  end

  def attribute_list(assigns) do
    ~H"""
    <div id={@id} class={@class} phx-update="prepend">
      <.attribute_item
        :for={attribute <- @attributes}
        attribute={attribute}
        edit={attribute.id == @edit_attribute_id}
        deleted={attribute.id == @deleted_attribute_id}
      />
    </div>
    """
  end

  def attribute_item(assigns) do
    ~H"""
    <div
      id={"attribute-#{@attribute.id}"}
      class={[@deleted && "hidden"]}
    >
      <div
        class="py-2 flex justify-between max-w-[350px] group"
      >
        <%= if @edit do %>
          <.live_component
            module={EditAttributeForm}
            id={@attribute.id}
            attribute={@attribute}
            form_class="-mt-10"
          />
        <% else %>
          <%= @attribute.label %> (<%= @attribute.type %>)
        <% end %>
        <div class="flex items-start mt-1 gap-4 text-xs font-bold text-blue-700 opacity-0 group-hover:opacity-100">
          <%= if @edit do %>
            <button phx-click="cancel_edit_attribute" phx-value-attribute_id={@attribute.id}>cancel</button>
          <% else %>
            <button phx-click="delete_attribute" phx-value-attribute_id={@attribute.id} class="text-red-400">delete</button>
            <button phx-click="edit_attribute" phx-value-attribute_id={@attribute.id}>edit</button>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    attributes = Catalog.list_attributes()

    socket = socket
      |> assign(show_new_form: false)
      |> assign(attributes: attributes)

    {:ok, socket, temporary_assigns: [
      attributes: [],
      deleted_attribute_id: nil]}
  end

  def handle_event("delete_attribute", %{"attribute_id" => attribute_id}, socket) do
    attribute_id = String.to_integer(attribute_id)
    socket = case Catalog.delete_attribute(%Attribute{id: attribute_id}) do
      {:ok, attribute} -> socket
        |> assign(attributes: [attribute])
      _ -> socket
    end
    {:noreply, socket}
  end

  def handle_event("edit_attribute", %{"attribute_id" => attribute_id}, socket) do
    attribute_id = String.to_integer(attribute_id)
    attribute = Catalog.get_attribute!(attribute_id)

    prev_edit_attribute = with id when not is_nil(id) and id != attribute_id <- socket.assigns[:edit_attribute_id]
    do
      [Catalog.get_attribute!(id)]
    else
      _ -> []
    end

    {:noreply, socket
      |> assign(edit_attribute_id: attribute_id)
      |> assign(attributes: [attribute | prev_edit_attribute])}
  end

  def handle_event("cancel_edit_attribute", %{"attribute_id" => attribute_id}, socket) do
    attribute_id = String.to_integer(attribute_id)
    attribute = Catalog.get_attribute!(attribute_id)
    {:noreply, socket
      |> assign(edit_attribute_id: nil)
      |> assign(attributes: [attribute])}
  end

  def handle_event("show_new_form", _, socket) do
    {:noreply, socket
      |> assign(show_new_form: not socket.assigns[:show_new_form])}
  end

  def handle_info({:added_attribute, attribute}, socket) do
    {:noreply, socket |> assign(attributes: [attribute])}
  end

  def handle_info({:updated_attribute, attribute}, socket) do
    {:noreply, socket
      |> assign(edit_attribute_id: nil)
      |> assign(attributes: [attribute])}
  end
end
