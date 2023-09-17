defmodule JualbeliWeb.AdminCategoriesLive.CategoryAttributes do
  use JualbeliWeb, :live_component
  alias Jualbeli.Repo
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.CategoryAttribute

  attr :class, :any, default: nil
  attr :new_attribute, :string, default: nil
  attr :attribute_options, :list, default: []

  def render(assigns) do
    ~H"""
    <div
      id={"category-attributes#{if @id, do: "-#{@id}", else: ""}"}
      class={@class}
    >
      <label class="text-sm font-bold mb-2 block">Attributes</label>
      <.attribute_item :for={attr <- @attributes} attribute={attr} target={@myself} />
      <details>
        <summary>Add attribute</summary>
        <.simple_form
          :if={@add_attribute_form}
          for={@add_attribute_form}
          class="-mt-8"
          phx-submit="add_attribute"
          phx-target={@myself}
        >
          <.input field={@add_attribute_form[:category_id]} type="hidden" value={@category.id} />
          <.input
            field={@add_attribute_form[:attribute_id]}
            type="select"
            options={@attribute_options}
          />
          <:actions>
            <.button class="-mt-6" phx-disable-with="Adding attribute...">Add</.button>
          </:actions>
        </.simple_form>
      </details>
    </div>
    """
  end

  def attribute_item(assigns) do
    ~H"""
    <div class="flex">
      <div class="min-w-[200px] mb-2">
        <%= @attribute.label %>
      </div>
      <div>
        <button
          class="text-xs text-red-400 font-bold"
          phx-click="delete_attribute"
          phx-value-attribute_id={@attribute.id}
          phx-target={@target}
        >
          delete
        </button>
      </div>
    </div>
    """
  end

  def handle_event("add_attribute", %{"category_attribute" => category_attribute_params}, socket) do
    case Catalog.create_category_attribute(category_attribute_params) do
      {:ok, _} ->
        attributes = Repo.preload(socket.assigns[:category], :attributes).attributes
        {:noreply, socket |> assign(attributes: attributes)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def handle_event("delete_attribute", %{"attribute_id" => attribute_id}, socket) do
    attribute_id = String.to_integer(attribute_id)
    case Catalog.delete_category_attribute(%CategoryAttribute{
      category_id: socket.assigns[:category].id,
      attribute_id: attribute_id
    }) do
      {1, nil} ->
        attributes = Repo.preload(socket.assigns[:category], :attributes).attributes
        {:noreply, socket |> assign(attributes: attributes)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def update(assigns, socket) do
    all_attributes = Catalog.list_attributes()
    attributes = Repo.preload(assigns[:category], :attributes).attributes
    attribute_options = all_attributes |> Enum.into([], fn a -> {a.label, a.id} end)

    category_attribute_changeset = Catalog.change_category_attribute(%CategoryAttribute{category_id: assigns[:category].id})

    socket = socket
      |> assign(assigns)
      |> assign(attributes: attributes)
      |> assign(attribute_options: attribute_options)
      |> assign(add_attribute_form: to_form(category_attribute_changeset))

    {:ok, socket}
  end
end
