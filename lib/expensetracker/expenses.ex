defmodule Expensetracker.Expenses do
  @moduledoc """
  The Expenses context.
  """

  alias Expensetracker.Expenses.Expense
  alias Expensetracker.Repo

  @doc """
  Returns a list of expenses.
  """
  def list_expenses do
    Repo.all(Expense) |> Repo.preload(:category)
  end

  @doc """
  Returns the total expenses for a given category.
  """
  def category_total_expenses(category_id) do
    expenses = list_expenses()

    expenses
    |> Enum.filter(fn expense -> expense.category.id == category_id end)
    |> Enum.reduce(0, fn expense, acc -> acc + expense.amount end)
  end

  @doc """
  Creates an expense.
  """
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end
end
