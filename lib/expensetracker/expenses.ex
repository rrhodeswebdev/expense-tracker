defmodule Expensetracker.Expense do
  @moduledoc """
  The Expense struct.
  """
  defstruct [:id, :category_id, :amount, :description, :date, :notes]
end

defmodule Expensetracker.Expenses do
  @moduledoc """
  The Expenses context.
  """

  @doc """
  Returns a list of expenses.
  """
  def list_expenses do
    [
      %Expensetracker.Expense{
        id: 1,
        category_id: 1,
        amount: 100,
        description: "Weekly Groceries",
        date: ~D[2023-01-01],
        notes: "Walmart weekly groceries"
      },
      %Expensetracker.Expense{
        id: 2,
        category_id: 2,
        amount: 40,
        description: "Daily Gas",
        date: ~D[2023-01-01],
        notes: "Daily gas fillup"
      },
      %Expensetracker.Expense{
        id: 3,
        category_id: 1,
        amount: 20,
        description: "Monthly Rent",
        date: ~D[2023-01-01],
        notes: "Monthly rent payment"
      },
      %Expensetracker.Expense{
        id: 4,
        category_id: 1,
        amount: 50,
        description: "Weekly Entertainment",
        date: ~D[2023-01-01],
        notes: "Weekly entertainment expenses"
      },
      %Expensetracker.Expense{
        id: 5,
        category_id: 2,
        amount: 10,
        description: "Daily Coffee",
        date: ~D[2023-01-01],
        notes: "Daily coffee purchase"
      },
      %Expensetracker.Expense{
        id: 6,
        category_id: 1,
        amount: 30,
        description: "Weekly Utilities",
        date: ~D[2023-01-01],
        notes: "Weekly utility expenses"
      },
      %Expensetracker.Expense{
        id: 7,
        category_id: 2,
        amount: 15,
        description: "Daily Breakfast",
        date: ~D[2023-01-01],
        notes: "Daily breakfast purchase"
      },
      %Expensetracker.Expense{
        id: 8,
        category_id: 1,
        amount: 25,
        description: "Weekly Clothing",
        date: ~D[2023-01-01],
        notes: "Weekly clothing purchase"
      },
      %Expensetracker.Expense{
        id: 9,
        category_id: 2,
        amount: 10,
        description: "Daily Snacks",
        date: ~D[2023-01-01],
        notes: "Daily snack purchase"
      },
      %Expensetracker.Expense{
        id: 10,
        category_id: 1,
        amount: 5,
        description: "Daily Water",
        date: ~D[2023-01-01],
        notes: "Daily water purchase"
      }
    ]
  end

  @doc """
  Returns the total expenses for a given category.
  """
  def category_total_expenses(category_id) do
    expenses = list_expenses()

    expenses
    |> Enum.filter(fn expense -> expense.category_id == category_id end)
    |> Enum.reduce(0, fn expense, acc -> acc + expense.amount end)
  end
end
