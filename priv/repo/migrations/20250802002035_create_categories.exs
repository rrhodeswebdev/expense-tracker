defmodule Expensetracker.Repo.Migrations.CreateCategories do
  @moduledoc """
  Create the categories table.
  """
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :text
      add :monthly_budget, :decimal, precision: 10, scale: 2

      timestamps(type: :utc_datetime)
    end
  end
end
