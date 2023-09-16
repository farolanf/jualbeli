defmodule JualbeliWeb.AdminAttributesLive.NewAttributeForm do
  use JualbeliWeb, :live_component
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Attribute

  attr :attribute, :any, default: nil
  attr :class, :any, default: nil
  attr :form_class, :any, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={"new-attribute-form#{if @id, do: "-#{@id}", else: ""}"}
      class={@class}
    >
      <.simple_form
        for={@form}
        phx-submit="add_attribute"
        phx-target={@myself}
        class={@form_class}
      >
        <.input field={@form[:label]} type="text" label="Label" required />
        <.input field={@form[:type]} type="text" label="Type" required />
        <:actions>
          <.button phx-disable-with="Adding attribute...">Add attribute</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("add_attribute", %{"attribute" => attribute_params}, socket) do
    case Catalog.create_attribute(attribute_params) do
      {:ok, attribute} ->
        send self(), {:added_attribute, attribute}
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def update(assigns, socket) do
    changeset = Catalog.change_attribute(%Attribute{})

    socket = socket
      |> assign(assigns)
      |> assign(form: to_form(changeset))

    {:ok, socket}
  end
end
