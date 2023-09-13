defmodule JualbeliWeb.AdminCategoriesLive do
  use JualbeliWeb, :live_view

  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Category

  attr :edit_category_id, :integer, default: nil
  attr :edit_form, :any, default: nil
  attr :deleted_category_id, :integer, default: nil

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Categories
    </.header>
    <div class="space-y-12">
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
      <div id="categories" phx-update="prepend">
        <.category_item
          :for={category <- @categories}
          category={category}
          edit={category.id == @edit_category_id}
          edit_form={@edit_form}
          deleted={category.id == @deleted_category_id}
        />
      </div>
    </div>
    """
  end

  def category_item(assigns) do
    ~H"""
    <div
      id={"category-#{@category.id}"}
      class={["py-2 flex justify-between items-center max-w-[350px]", @deleted && "hidden"]}
    >
      <%= if @edit do %>
        <.simple_form
          for={@edit_form}
          id="edit_form"
          phx-submit="update_category"
        >
          <.input field={@edit_form[:id]} type="hidden" />
          <.input field={@edit_form[:title]} type="text" label="Title" required />
          <:actions>
            <.button phx-disable-with="Updating category...">Update category</.button>
          </:actions>
        </.simple_form>
      <% else %>
        <%= @category.title %>
      <% end %>
      <div class="flex items-center gap-4 text-xs font-bold text-blue-700">
        <%= if @edit do %>
          <button phx-click="cancel_edit_category" phx-value-category_id={@category.id}>cancel</button>
        <% else %>
          <button phx-click="edit_category" phx-value-category_id={@category.id}>edit</button>
          <button phx-click="delete_category" phx-value-category_id={@category.id} class="text-red-400">delete</button>
          <button>+</button>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    new_changeset = Catalog.change_category(%Category{})
    categories = Catalog.list_categories(roots: true)

    socket = socket
      |> assign(new_form: to_form(new_changeset))
      |> assign(categories: categories)

    {:ok, socket, temporary_assigns: [
      new_form: nil,
      edit_form: nil,
      categories: [],
      deleted_category_id: nil]}
  end

  def handle_event("add_category", %{"category" => category_params}, socket) do
    case Catalog.create_category(category_params) do
      {:ok, category} ->
        new_changeset = Catalog.change_category(%Category{})
        {:noreply, socket
          |> assign(new_form: to_form(new_changeset))
          |> assign(categories: [category])}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(new_form: to_form(changeset))}
    end
  end

  def handle_event("update_category", %{"category" => category_params}, socket) do
    category = Catalog.get_category!(category_params["id"])
    case Catalog.update_category(category, category_params) do
      {:ok, category} ->
        {:noreply, socket
          |> assign(edit_category_id: nil)
          |> assign(categories: [category])}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket
          |> assign(edit_form: to_form(changeset))
          |> assign(categories: [changeset.data])}
    end
  end

  def handle_event("delete_category", %{"category_id" => category_id}, socket) do
    category = Catalog.get_category!(category_id)
    socket = case Catalog.delete_category(category) do
      {:ok, category} -> socket
        |> assign(categories: [category])
        |> assign(deleted_category_id: category.id)
      _ -> socket
    end
    {:noreply, socket}
  end

  def handle_event("edit_category", %{"category_id" => category_id}, socket) do
    prev_edit_category = case socket.assigns[:edit_category_id] do
      nil -> []
      id -> [Catalog.get_category!(id)]
    end

    category = Catalog.get_category!(category_id)
    changeset = Catalog.change_category(category)

    {:noreply, socket
      |> assign(edit_category_id: String.to_integer(category_id))
      |> assign(edit_form: to_form(changeset))
      |> assign(categories: [category | prev_edit_category])}
  end

  def handle_event("cancel_edit_category", %{"category_id" => category_id}, socket) do
    category = Catalog.get_category!(category_id)
    {:noreply, socket
      |> assign(edit_category_id: nil)
      |> assign(categories: [category])}
  end
end
