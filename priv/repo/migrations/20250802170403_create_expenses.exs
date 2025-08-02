defmodule Expensetracker.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :description, :text
      add :amount, :decimal
      add :date, :date
      add :notes, :text
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:expenses, [:category_id])
  end
end
