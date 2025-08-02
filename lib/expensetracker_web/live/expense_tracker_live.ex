defmodule ExpensetrackerWeb.ExpenseTrackerLive do
  use ExpensetrackerWeb, :live_view
  alias Expensetracker.Categories
  alias Expensetracker.Categories.Category

  def mount(_params, _session, socket) do
    categories = Categories.list_categories()
    expenses = Expensetracker.Expenses.list_expenses()
    changeset = Categories.change_category(%Category{})

    {:ok,
     assign(socket,
       show_form: false,
       show_expense_form: false,
       expanded_categories: MapSet.new(),
       categories: categories,
       expenses: expenses,
       category_form: to_form(changeset)
     )}
  end

  def handle_event("toggle_form", _params, socket) do
    changeset = Categories.change_category(%Category{})

    {:noreply,
     assign(socket, show_form: !socket.assigns.show_form, category_form: to_form(changeset))}
  end

  def handle_event("toggle_category", %{"id" => id}, socket) do
    category_id = String.to_integer(id)
    expanded = socket.assigns.expanded_categories

    new_expanded =
      if MapSet.member?(expanded, category_id) do
        MapSet.delete(expanded, category_id)
      else
        MapSet.put(expanded, category_id)
      end

    {:noreply, assign(socket, expanded_categories: new_expanded)}
  end

  def handle_event("toggle_expense_form", _params, socket) do
    {:noreply, assign(socket, show_expense_form: !socket.assigns.show_expense_form)}
  end

  def handle_event("validate_category", %{"category" => category_params}, socket) do
    changeset = Categories.change_category(%Category{}, category_params)
    {:noreply, assign(socket, :category_form, to_form(changeset, action: :validate_category))}
  end

  def handle_event(
        "create_category",
        %{"category" => category_params},
        socket
      ) do
    case Categories.create_category(category_params) do
      {:ok, _category} ->
        categories = Categories.list_categories()

        {:noreply,
         assign(socket, categories: categories, show_form: false, category_form: to_form(%{}))}

      {:error, changeset} ->
        {:noreply, assign(socket, :category_form, to_form(changeset))}
    end
  end
end
