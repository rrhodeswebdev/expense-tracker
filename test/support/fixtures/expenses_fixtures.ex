defmodule Expensetracker.ExpensesFixtures do
  @moduledoc """
  Test fixtures for expenses.
  """
  def expense_fixture(attrs \\ %{}) do
    category =
      unless attrs[:category_id],
        do: Expensetracker.CategoriesFixtures.category_fixture(),
        else: nil

    {:ok, expense} =
      attrs
      |> Enum.into(%{
        description: "Test Expense #{System.unique_integer()}",
        amount: Decimal.new("50.00"),
        date: ~D[2024-01-15],
        notes: "Test notes",
        category_id: attrs[:category_id] || category.id
      })
      |> Expensetracker.Expenses.create_expense()

    expense
  end
end
