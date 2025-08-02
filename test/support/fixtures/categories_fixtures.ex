defmodule Expensetracker.CategoriesFixtures do
  @moduledoc """
  Test fixtures for categories.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "Test Category #{System.unique_integer()}",
        description: "Test description",
        monthly_budget: Decimal.new("100.00")
      })
      |> Expensetracker.Categories.create_category()

    category
  end
end
