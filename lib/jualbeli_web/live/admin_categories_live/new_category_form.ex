defmodule JualbeliWeb.AdminCategoriesLive.NewCategoryForm do
  use JualbeliWeb, :live_component
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Category

  attr :category, :any, default: nil
  attr :class, :any, default: nil
  attr :form_class, :any, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={"new-category-form#{if @id, do: "-#{@id}", else: ""}"}
      class={@class}
    >
      <.simple_form
        for={@form}
        phx-submit="add_category"
        phx-target={@myself}
        class={@form_class}
      >
        <.input field={@form[:parent_id]} type="hidden" />
        <.input field={@form[:title]} type="text" label="Title" required />
        <:actions>
          <.button phx-disable-with="Adding category...">Add category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("add_category", %{"category" => category_params}, socket) do
    case Catalog.create_category(category_params) do
      {:ok, category} ->
        send self(), {:added_category, category}
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def update(assigns, socket) do
    changeset = Catalog.change_category(%Category{parent_id: assigns[:parent_id]})

    socket = socket
      |> assign(assigns)
      |> assign(form: to_form(changeset))

    {:ok, socket}
  end
end
