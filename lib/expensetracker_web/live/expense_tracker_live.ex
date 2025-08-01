defmodule ExpensetrackerWeb.ExpenseTrackerLive do
  use ExpensetrackerWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, show_form: false, show_expense_form: false, expanded_categories: MapSet.new())}
  end

  def handle_event("toggle_form", _params, socket) do
    {:noreply, assign(socket, show_form: !socket.assigns.show_form)}
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
end
