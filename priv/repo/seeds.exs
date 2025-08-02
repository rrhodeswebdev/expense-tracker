alias Expensetracker.Repo
alias Expensetracker.Categories.Category

categories = [
  %{
    name: "Groceries",
    description: "Food and household essentials",
    monthly_budget: Decimal.new("500.00")
  },
  %{
    name: "Gas",
    description: "Vehicle fuel expenses",
    monthly_budget: Decimal.new("200.00")
  },
  %{
    name: "Entertainment",
    description: "Movies, dining out, and leisure activities",
    monthly_budget: Decimal.new("300.00")
  },
  %{
    name: "Utilities",
    description: "Electricity, water, internet, and phone bills",
    monthly_budget: Decimal.new("250.00")
  },
  %{
    name: "Transportation",
    description: "Public transport, parking, and vehicle maintenance",
    monthly_budget: Decimal.new("150.00")
  }
]

Enum.each(categories, fn category_attrs ->
  %Category{}
  |> Category.changeset(category_attrs)
  |> Repo.insert!()
end)
