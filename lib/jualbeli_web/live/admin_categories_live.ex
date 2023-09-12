defmodule JualbeliWeb.AdminCategoriesLive do
  use JualbeliWeb, :live_view

  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Category

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Categories
    </.header>
    <div class="space-y-12 divide-y">
      <div>
        <.simple_form
          for={@new_form}
          id="new_form"
          phx-submit="add_category"
        >
          <.input field={@new_form[:title]} type="text" label="Title" required />
          <:actions>
            <.button phx-disable-with="Adding category...">Add category</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    new_changeset = Catalog.change_category(%Category{})

    socket = socket
      |> assign_new_form(new_changeset)

    {:ok, socket, temporary_assigns: [new_form: nil]}
  end

  def handle_event("add_category", %{"category" => category_params}, socket) do
    case Catalog.create_category(category_params) do
      {:ok, category} ->
        new_changeset = Catalog.change_category(%Category{})
        {:noreply, socket |> assign_new_form(new_changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign_new_form(changeset)}
    end
  end

  def assign_new_form(socket, changeset) do
    socket
      |> assign(new_form: to_form(changeset))
  end
end
