defmodule Expensetracker.Expenses.Expense do
  @moduledoc """
  The Expense schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :date, :date
    field :description, :string
    field :amount, :decimal
    field :notes, :string

    belongs_to :category, Expensetracker.Categories.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:description, :amount, :date, :notes, :category_id])
    |> validate_required([:description, :amount, :date, :category_id])
    |> validate_number(:amount, greater_than: 0)
    |> validate_length(:description, min: 3)
  end
end
