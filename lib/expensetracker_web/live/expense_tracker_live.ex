defmodule ExpensetrackerWeb.ExpenseTrackerLive do
  use ExpensetrackerWeb, :live_view
  alias Expensetracker.Categories
  alias Expensetracker.Categories.Category
  alias Expensetracker.Expenses
  alias Expensetracker.Expenses.Expense

  def mount(_params, _session, socket) do
    categories = Categories.list_categories()
    expenses = Expenses.list_expenses()
    category_changeset = Categories.change_category(%Category{})
    expense_changeset = Expenses.change_expense(%Expense{})

    category_options = Enum.map(categories, &{&1.name, &1.id})

    categories_with_totals =
      Enum.map(categories, fn category ->
        total_expenses =
          expenses
          |> Enum.filter(&(&1.category_id == category.id))
          |> Enum.reduce(Decimal.new(0), &Decimal.add(&2, &1.amount))

        Map.put(category, :total_expenses, total_expenses)
      end)

    {:ok,
     assign(socket,
       show_form: false,
       show_expense_form: false,
       expanded_categories: MapSet.new(),
       categories: categories_with_totals,
       category_options: category_options,
       expenses: expenses,
       category_form: to_form(category_changeset),
       expense_form: to_form(expense_changeset)
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
    changeset = Expenses.change_expense(%Expense{})

    {:noreply,
     assign(socket,
       show_expense_form: !socket.assigns.show_expense_form,
       expense_form: to_form(changeset)
     )}
  end

  def handle_event("validate_category", %{"category" => category_params}, socket) do
    changeset = Categories.change_category(%Category{}, category_params)
    {:noreply, assign(socket, :category_form, to_form(changeset, action: :validate_category))}
  end

  def handle_event("validate_expense", %{"expense" => expense_params}, socket) do
    changeset = Expenses.change_expense(%Expense{}, expense_params)
    {:noreply, assign(socket, :expense_form, to_form(changeset, action: :validate_expense))}
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

  def handle_event("create_expense", %{"expense" => expense_params}, socket) do
    case Expenses.create_expense(expense_params) do
      {:ok, _expense} ->
        expenses = Expenses.list_expenses()
        categories = Categories.list_categories()
        category_options = Enum.map(categories, &{&1.name, &1.id})

        categories_with_totals =
          Enum.map(categories, fn category ->
            total_expenses =
              expenses
              |> Enum.filter(&(&1.category_id == category.id))
              |> Enum.reduce(Decimal.new(0), &Decimal.add(&2, &1.amount))

            Map.put(category, :total_expenses, total_expenses)
          end)

        {:noreply,
         assign(socket,
           expenses: expenses,
           categories: categories_with_totals,
           category_options: category_options,
           show_expense_form: false,
           expense_form: to_form(%{})
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, :expense_form, to_form(changeset))}
    end
  end
end
