defmodule Expensetracker.Category do
  @moduledoc """
  The Category struct.
  """
  defstruct [:id, :name, :description, :monthly_budget]
end

defmodule Expensetracker.Categories do
  @moduledoc """
  The Categories context.
  """
  def list_categories do
    [
      %Expensetracker.Category{
        id: 1,
        name: "Groceries",
        description: "Groceries",
        monthly_budget: 500
      },
      %Expensetracker.Category{
        id: 2,
        name: "Gas",
        description: "Gas",
        monthly_budget: 200
      }
    ]
  end
end
