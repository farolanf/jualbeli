defmodule JualbeliWeb.NewProductLive do
  use JualbeliWeb, :live_view
  alias Jualbeli.Catalog
  alias Jualbeli.Catalog.{Product, Category}

  def render(assigns) do
    ~H"""
    <h1 class="text-xl">Pasang Iklan</h1>
    <.simple_form
      for={@form}
      phx-submit="create_product"
    >
      <.input field={@form[:title]} label="Judul" required />
      <.input field={@form[:description]} label="Deskripsi" required />
      <.input field={@form[:price]} label="Harga" required />
      <.input field={@form[:category_id]} label="Kategori" type="select" options={@category_options} required />
      <:actions>
        <.button type="submit" phx-disable-with="Memasang iklan...">Pasang iklan</.button>
      </:actions>
    </.simple_form>
    """
  end

  def handle_event("create_product", %{"product" => product_params}, socket) do
    case Catalog.create_product(product_params) do
      {:ok, product} ->
          {:noreply, socket |> push_navigate(to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, socket |> assign(form: to_form(changeset))}
    end
  end

  def mount(_params, _session, socket) do
    changeset = Catalog.change_product(%Product{})

    categories = Catalog.list_categories(order_by: :title)
    category_options = categories
      |> Enum.filter(fn c -> is_nil(c.parent_id) end)
      |> Enum.into([], fn c -> build_category_options(categories, c) end)
      |> List.flatten()

    socket = socket
      |> assign(form: to_form(changeset))
      |> assign(category_options: category_options)

    {:ok, socket}
  end

  def build_category_options(categories, %Category{} = category, prefix \\ nil) do
    child_prefix = [prefix, category.title]
      |> Enum.filter(fn x -> !is_nil(x) end)
      |> Enum.join("/")

    children = categories
      |> Enum.filter(fn c -> c.parent_id == category.id end)
      |> Enum.into([], fn c -> build_category_options(categories, c, child_prefix) end)

    title = [prefix, category.title]
      |> Enum.filter(fn x -> !is_nil(x) end)
      |> Enum.join("/")

    [{title, category.id} | children]
  end
end
