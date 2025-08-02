alias Expensetracker.Repo
alias Expensetracker.Categories.Category
alias Expensetracker.Expenses.Expense

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

expenses = [
  %{
    description: "Weekly Groceries",
    amount: Decimal.new("85.50"),
    date: ~D[2024-01-15],
    notes: "Walmart weekly groceries",
    category_id: 1
  },
  %{
    description: "Organic Vegetables",
    amount: Decimal.new("32.75"),
    date: ~D[2024-01-18],
    notes: "Fresh produce from farmers market",
    category_id: 1
  },
  %{
    description: "Gas Fill-up",
    amount: Decimal.new("45.20"),
    date: ~D[2024-01-16],
    notes: "Shell gas station",
    category_id: 2
  },
  %{
    description: "Highway Gas",
    amount: Decimal.new("38.90"),
    date: ~D[2024-01-20],
    notes: "Road trip fuel",
    category_id: 2
  },
  %{
    description: "Movie Night",
    amount: Decimal.new("28.50"),
    date: ~D[2024-01-14],
    notes: "Cinema tickets for two",
    category_id: 3
  },
  %{
    description: "Dinner Out",
    amount: Decimal.new("67.80"),
    date: ~D[2024-01-19],
    notes: "Italian restaurant",
    category_id: 3
  },
  %{
    description: "Electricity Bill",
    amount: Decimal.new("89.45"),
    date: ~D[2024-01-12],
    notes: "Monthly electricity payment",
    category_id: 4
  },
  %{
    description: "Internet Service",
    amount: Decimal.new("59.99"),
    date: ~D[2024-01-10],
    notes: "Monthly broadband",
    category_id: 4
  },
  %{
    description: "Bus Pass",
    amount: Decimal.new("25.00"),
    date: ~D[2024-01-08],
    notes: "Weekly public transport pass",
    category_id: 5
  },
  %{
    description: "Parking Fee",
    amount: Decimal.new("12.00"),
    date: ~D[2024-01-17],
    notes: "Downtown parking meter",
    category_id: 5
  }
]

Enum.each(expenses, fn expense_attrs ->
  %Expense{}
  |> Expense.changeset(expense_attrs)
  |> Repo.insert!()
end)
