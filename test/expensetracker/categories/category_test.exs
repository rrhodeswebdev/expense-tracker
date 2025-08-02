defmodule Expensetracker.Categories.CategoryTest do
  @moduledoc """
  Test the Category schema.
  """
  use Expensetracker.DataCase

  alias Expensetracker.Categories.Category

  @valid_attrs %{
    name: "Test Category",
    description: "Test description",
    monthly_budget: "100.00"
  }

  @invalid_attrs %{name: nil, description: nil, monthly_budget: nil}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
    assert "can't be blank" in errors_on(changeset).name
    assert "can't be blank" in errors_on(changeset).description
    assert "can't be blank" in errors_on(changeset).monthly_budget
  end

  test "changeset requires name to be at least 3 characters" do
    attrs = %{@valid_attrs | name: "ab"}
    changeset = Category.changeset(%Category{}, attrs)
    refute changeset.valid?
    assert "should be at least 3 character(s)" in errors_on(changeset).name
  end

  test "changeset requires description to be at least 3 characters" do
    attrs = %{@valid_attrs | description: "ab"}
    changeset = Category.changeset(%Category{}, attrs)
    refute changeset.valid?
    assert "should be at least 3 character(s)" in errors_on(changeset).description
  end

  test "changeset requires monthly_budget to be greater than 0" do
    attrs = %{@valid_attrs | monthly_budget: "0"}
    changeset = Category.changeset(%Category{}, attrs)
    refute changeset.valid?
    assert "must be greater than 0" in errors_on(changeset).monthly_budget
  end

  test "changeset rejects negative monthly_budget" do
    attrs = %{@valid_attrs | monthly_budget: "-10.00"}
    changeset = Category.changeset(%Category{}, attrs)
    refute changeset.valid?
    assert "must be greater than 0" in errors_on(changeset).monthly_budget
  end
end
