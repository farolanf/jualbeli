defmodule JualbeliWeb.AdminCategoriesLive.EditCategoryForm do
  use JualbeliWeb, :live_component
  alias Jualbeli.Catalog

  attr :form, :any, default: nil
  attr :form_class, :any, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={"edit-category-form#{if @id, do: "-#{@id}", else: ""}"}
    >
      <.simple_form
        :if={@form}
        for={@form}
        phx-submit="update_category"
        phx-target={@myself}
        class={@form_class}
      >
        <.input field={@form[:id]} type="hidden" />
        <.input field={@form[:title]} type="text" label="Title" required />
        <:actions>
          <.button phx-disable-with="Updating category...">Update category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("update_category", %{"category" => category_params}, socket) do
    category = Catalog.get_category!(category_params["id"])
    case Catalog.update_category(category, category_params) do
      {:ok, category} ->
        send self(), {:updated_category, category}
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns)

    socket = if assigns[:category] do
      changeset = Catalog.change_category(assigns[:category])
      socket |> assign(form: to_form(changeset))
    else
      socket
    end

    {:ok, socket}
  end
end
