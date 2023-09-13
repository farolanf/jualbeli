defmodule JualbeliWeb.AdminCategoriesLive do
  use JualbeliWeb, :live_view

  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Category

  attr :edit_category_id, :integer, default: nil
  attr :edit_form, :any, default: nil
  attr :deleted_category_id, :integer, default: nil
  attr :expand, :map, default: %{}

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
      <.category_list
        id="categories"
        class=""
        children={Enum.filter(@categories, fn c -> is_nil(c.parent_id) end)}
        categories={@categories}
        edit_category_id={@edit_category_id}
        deleted_category_id={@deleted_category_id}
        edit_form={@edit_form}
        new_form={@new_form}
        expand={@expand}
      />
    </div>
    """
  end

  def category_list(assigns) do
    ~H"""
    <div id={@id} class={@class} phx-update="prepend">
      <.category_item
        :for={category <- @children}
        category={category}
        edit={category.id == @edit_category_id}
        deleted={category.id == @deleted_category_id}
        expanded={@expand[category.id]}
        children={Enum.filter(@categories, fn c -> c.parent_id == category.id end)}
        categories={@categories}
        edit_category_id={@edit_category_id}
        deleted_category_id={@deleted_category_id}
        edit_form={@edit_form}
        new_form={@new_form}
        expand={@expand}
      />
    </div>
    """
  end

  def category_item(assigns) do
    ~H"""
    <div
      id={"category-#{@category.id}"}
      class={[@deleted && "hidden"]}
    >
      <div
        class="py-2 flex justify-between max-w-[350px]"
      >
        <%= if @edit do %>
          <.simple_form
            for={@edit_form}
            id="edit_form"
            phx-submit="update_category"
            class="-mt-10"
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
        <div class="flex items-start mt-1 gap-4 text-xs font-bold text-blue-700">
          <%= if @edit do %>
            <button phx-click="cancel_edit_category" phx-value-category_id={@category.id}>cancel</button>
          <% else %>
            <button phx-click="delete_category" phx-value-category_id={@category.id} class="text-red-400">delete</button>
            <button phx-click="edit_category" phx-value-category_id={@category.id}>edit</button>
            <button :if={@expanded} phx-click={JS.toggle(to: "#new_form-#{@category.id}")}>add</button>
            <button :if={!@expanded} phx-click="expand" phx-value-category_id={@category.id}>+</button>
            <button :if={@expanded} phx-click="collapse" phx-value-category_id={@category.id}>-</button>
          <% end %>
        </div>
      </div>
      <div
        :if={@expanded}
        id={"category-more-#{@category.id}"}
      >
        <.simple_form
          for={@new_form}
          id={"new_form-#{@category.id}"}
          phx-submit="add_category"
          class="-mt-6 pl-8 hidden"
        >
          <.input field={@new_form[:parent_id]} type="hidden" />
          <.input field={@new_form[:title]} type="text" label="Title" required />
          <:actions>
            <.button phx-disable-with="Adding category...">Add category</.button>
          </:actions>
        </.simple_form>
        <.category_list
          id={"category-children-#{@category.id}"}
          class="my-4 pl-8"
          children={Enum.filter(@categories, fn c -> c.parent_id == @category.id end)}
          categories={@categories}
          edit_category_id={@edit_category_id}
          deleted_category_id={@deleted_category_id}
          edit_form={@edit_form}
          new_form={@new_form}
          expand={@expand}
        />
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
      |> assign(expand: %{})

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

  def handle_event("expand", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    new_changeset = Catalog.change_category(%Category{parent_id: category_id})
    category = Catalog.get_category!(category_id)
    children = Catalog.list_categories(parent_id: category.id)
    {:noreply, socket
      |> assign(expand: Map.put(socket.assigns[:expand], category_id, true))
      |> assign(categories: [category | children])
      |> assign(new_form: to_form(new_changeset))}
  end

  def handle_event("collapse", %{"category_id" => category_id}, socket) do
    category = Catalog.get_category!(category_id)
    {:noreply, socket
      |> assign(expand: Map.delete(socket.assigns[:expand], String.to_integer(category_id)))
      |> assign(categories: [category])}
  end
end
