defmodule Expensetracker.Expenses.ExpenseTest do
  @moduledoc """
  Test the Expense schema.
  """
  use Expensetracker.DataCase

  alias Expensetracker.Expenses.Expense

  @valid_attrs %{
    description: "Test Expense",
    amount: "50.00",
    date: ~D[2024-01-15],
    notes: "Test notes",
    category_id: 1
  }

  @invalid_attrs %{description: nil, amount: nil, date: nil, notes: nil, category_id: nil}

  test "changeset with valid attributes" do
    changeset = Expense.changeset(%Expense{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Expense.changeset(%Expense{}, @invalid_attrs)
    refute changeset.valid?
    assert "can't be blank" in errors_on(changeset).description
    assert "can't be blank" in errors_on(changeset).amount
    assert "can't be blank" in errors_on(changeset).date
    assert "can't be blank" in errors_on(changeset).category_id
  end

  test "changeset requires description to be at least 3 characters" do
    attrs = %{@valid_attrs | description: "ab"}
    changeset = Expense.changeset(%Expense{}, attrs)
    refute changeset.valid?
    assert "should be at least 3 character(s)" in errors_on(changeset).description
  end

  test "changeset requires amount to be greater than 0" do
    attrs = %{@valid_attrs | amount: "0"}
    changeset = Expense.changeset(%Expense{}, attrs)
    refute changeset.valid?
    assert "must be greater than 0" in errors_on(changeset).amount
  end

  test "changeset rejects negative amount" do
    attrs = %{@valid_attrs | amount: "-10.00"}
    changeset = Expense.changeset(%Expense{}, attrs)
    refute changeset.valid?
    assert "must be greater than 0" in errors_on(changeset).amount
  end

  test "changeset allows notes to be nil" do
    attrs = %{@valid_attrs | notes: nil}
    changeset = Expense.changeset(%Expense{}, attrs)
    assert changeset.valid?
  end
end
