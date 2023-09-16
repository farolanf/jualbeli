defmodule JualbeliWeb.AdminAttributesLive.EditAttributeForm do
  use JualbeliWeb, :live_component
  alias Jualbeli.Catalog

  attr :form, :any, default: nil
  attr :form_class, :any, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={"edit-attribute-form#{if @id, do: "-#{@id}", else: ""}"}
    >
      <.simple_form
        :if={@form}
        for={@form}
        phx-submit="update_attribute"
        phx-target={@myself}
        class={@form_class}
      >
        <.input field={@form[:id]} type="hidden" />
        <.input field={@form[:label]} type="text" label="Label" required />
        <.input field={@form[:type]} type="text" label="Type" required />
        <:actions>
          <.button phx-disable-with="Updating attribute...">Update attribute</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update_attribute", %{"attribute" => attribute_params}, socket) do
    attribute = Catalog.get_attribute!(attribute_params["id"])
    case Catalog.update_attribute(attribute, attribute_params) do
      {:ok, attribute} ->
        send self(), {:updated_attribute, attribute}
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns)

    socket = if assigns[:attribute] do
      changeset = Catalog.change_attribute(assigns[:attribute])
      socket |> assign(form: to_form(changeset))
    else
      socket
    end

    {:ok, socket}
  end
end
