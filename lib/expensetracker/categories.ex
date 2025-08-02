defmodule Expensetracker.Categories do
  @moduledoc """
  The Categories context.
  """

  alias Expensetracker.Categories.Category
  alias Expensetracker.Repo

  def list_categories do
    Repo.all(Category)
  end

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end
end
