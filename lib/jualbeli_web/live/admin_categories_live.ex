defmodule JualbeliWeb.AdminCategoriesLive do
  use JualbeliWeb, :live_view
  alias JualbeliWeb.AdminCategoriesLive.{NewCategoryForm, EditCategoryForm, CategoryAttributes}
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.Category

  attr :edit_category_id, :integer, default: nil
  attr :deleted_category_id, :integer, default: nil
  attr :expand, :map, default: %{}
  attr :show_new_form, :integer, default: nil
  attr :show_attributes, :integer, default: nil

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Categories
    </.header>
    <div class="space-y-12">
      <div class="flex gap-6">
        <button
          phx-click="show_new_form"
          class="text-xs font-bold text-blue-700"
        >
          New category
        </button>
        <button
          phx-click="expand_all"
          class="text-xs font-bold text-blue-700"
        >
          Expand all
        </button>
        <button
          phx-click="collapse_all"
          class="text-xs font-bold text-blue-700"
        >
          Collapse all
        </button>
      </div>
      <.live_component
        :if={@show_new_form == 0}
        module={NewCategoryForm}
        id="root"
        form_class="-mt-8"
      />
      <.category_list
        id="categories"
        class=""
        children={Enum.filter(@categories, fn c -> is_nil(c.parent_id) end)}
        categories={@categories}
        edit_category_id={@edit_category_id}
        deleted_category_id={@deleted_category_id}
        expand={@expand}
        show_new_form={@show_new_form}
        show_attributes={@show_attributes}
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
        expand={@expand}
        show_new_form={@show_new_form}
        show_attributes={@show_attributes}
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
        class="py-2 flex justify-between max-w-[350px] group"
      >
        <%= if @edit do %>
          <.live_component
            module={EditCategoryForm}
            id={@category.id}
            category={@category}
            form_class="-mt-10"
          />
        <% else %>
          <%= @category.title %>
        <% end %>
        <div class="flex items-start mt-1 gap-4 text-xs font-bold text-blue-700 opacity-0 group-hover:opacity-100">
          <%= if @edit do %>
            <button phx-click="cancel_edit_category" phx-value-category_id={@category.id}>cancel</button>
          <% else %>
            <button phx-click="delete_category" phx-value-category_id={@category.id} class="text-red-400">delete</button>
            <button phx-click="edit_category" phx-value-category_id={@category.id}>edit</button>
            <button phx-click="show_new_child_form" phx-value-category_id={@category.id}>new</button>
            <button phx-click="show_attributes" phx-value-category_id={@category.id}>attrs</button>
            <button :if={!@expanded} phx-click="expand" phx-value-category_id={@category.id}>+</button>
            <button :if={@expanded} phx-click="collapse" phx-value-category_id={@category.id}>-</button>
          <% end %>
        </div>
      </div>
      <div
        :if={@expanded}
        id={"category-more-#{@category.id}"}
      >
        <.live_component
          module={CategoryAttributes}
          id={@category.id}
          category={@category}
          class={["pl-8", @show_attributes != @category.id && "hidden"]}
        />
        <.live_component
          module={NewCategoryForm}
          id={@category.id}
          parent_id={@category.id}
          class={[@show_new_form != @category.id && "hidden"]}
          form_class="-mt-6 pl-8"
        />
        <.category_list
          id={"category-children-#{@category.id}"}
          class="my-4 pl-8"
          children={Enum.filter(@categories, fn c -> c.parent_id == @category.id end)}
          categories={@categories}
          edit_category_id={@edit_category_id}
          deleted_category_id={@deleted_category_id}
          expand={@expand}
          show_new_form={@show_new_form}
          show_attributes={@show_attributes}
        />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    categories = Catalog.list_categories(roots: true)

    socket = socket
      |> assign(categories: categories)
      |> assign(expand: %{})

    {:ok, socket, temporary_assigns: [
      categories: [],
      deleted_category_id: nil]}
  end

  def handle_event("delete_category", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    categories = Catalog.category_ancestors(category_id, self: true)
    socket = case Catalog.delete_category(%Category{id: category_id}) do
      {:ok, _} -> socket
        |> assign(categories: categories)
        |> assign(deleted_category_id: category_id)
      _ -> socket
    end
    {:noreply, socket}
  end

  def handle_event("edit_category", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)

    prev_edit_category = with id when not is_nil(id) and id != category_id <- socket.assigns[:edit_category_id]
    do
      [Catalog.get_category!(id)]
    else
      _ -> []
    end

    categories = Catalog.category_ancestors(category_id, self: true)

    {:noreply, socket
      |> assign(edit_category_id: category_id)
      |> assign(categories: prev_edit_category ++ categories)}
  end

  def handle_event("cancel_edit_category", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    categories = Catalog.category_ancestors(category_id, self: true)
    {:noreply, socket
      |> assign(edit_category_id: nil)
      |> assign(categories: categories)}
  end

  def handle_event("expand", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    children = Catalog.list_categories(parent_id: category_id)
    categories = Catalog.category_ancestors(category_id, self: true)
    {:noreply, socket
      |> assign(expand: Map.put(socket.assigns[:expand], category_id, true))
      |> assign(categories: children ++ categories)}
  end

  def handle_event("collapse", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    categories = Catalog.category_ancestors(category_id, self: true)
    {:noreply, socket
      |> assign(expand: Map.delete(socket.assigns[:expand], category_id))
      |> assign(categories: categories)}
  end

  def handle_event("expand_all", _, socket) do
    categories = Catalog.list_categories()
    expand = Enum.into(categories, %{}, fn c -> {c.id, true} end)
    {:noreply, socket
      |> assign(expand: expand)
      |> assign(categories: categories)}
  end

  def handle_event("collapse_all", _, socket) do
    categories = Catalog.list_categories()
    {:noreply, socket
      |> assign(expand: %{})
      |> assign(categories: categories)}
  end

  def handle_event("show_new_form", _, socket) do
    prev_show = socket.assigns[:show_new_form]

    show_new_form = if prev_show && prev_show == 0, do: nil, else: 0

    categories = if prev_show && prev_show != 0 do
      Catalog.category_ancestors(prev_show, self: true)
    else
      []
    end

    {:noreply, socket
      |> assign(show_new_form: show_new_form)
      |> assign(categories: categories)}
  end

  def handle_event("show_new_child_form", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    category = Catalog.get_category!(category_id)
    children = Catalog.list_categories(parent_id: category.id)
    ancestors = Catalog.category_ancestors(category.id)

    categories = [category | children] ++ ancestors

    prev_show = socket.assigns[:show_new_form]

    show_new_form = if prev_show && prev_show == category.id, do: nil, else: category.id

    categories = if prev_show && prev_show != 0 && prev_show != category.id do
      if Enum.any?(categories, fn c -> c.id == prev_show end) do
        categories
      else
        [Catalog.get_category!(prev_show) | categories]
      end
    else
      categories
    end

    {:noreply, socket
      |> assign(show_new_form: show_new_form)
      |> assign(expand: Map.put(socket.assigns[:expand], category_id, true))
      |> assign(categories: categories)}
  end

  def handle_event("show_attributes", %{"category_id" => category_id}, socket) do
    category_id = String.to_integer(category_id)
    category = Catalog.get_category!(category_id)
    children = Catalog.list_categories(parent_id: category.id)
    ancestors = Catalog.category_ancestors(category.id)

    categories = [category | children] ++ ancestors

    prev_show = socket.assigns[:show_attributes]

    show_attributes = if prev_show && prev_show == category.id, do: nil, else: category.id

    categories = if prev_show && prev_show != 0 && prev_show != category.id do
      if Enum.any?(categories, fn c -> c.id == prev_show end) do
        categories
      else
        [Catalog.get_category!(prev_show) | categories]
      end
    else
      categories
    end

    {:noreply, socket
      |> assign(show_attributes: show_attributes)
      |> assign(expand: Map.put(socket.assigns[:expand], category_id, true))
      |> assign(categories: categories)}
  end

  def handle_info({:added_category, category}, socket) do
    ancestors = Catalog.category_ancestors(category.id)
    {:noreply, socket |> assign(categories: [category | ancestors])}
  end

  def handle_info({:updated_category, category}, socket) do
    ancestors = Catalog.category_ancestors(category.id)
    {:noreply, socket
      |> assign(edit_category_id: nil)
      |> assign(categories: [category | ancestors])}
  end
end
