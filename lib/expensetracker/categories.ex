defmodule Expensetracker.Categories do
  @moduledoc """
  The Categories context.
  """

  alias Expensetracker.Categories.Category
  alias Expensetracker.Repo

  def list_categories do
    Repo.all(Category)
  end
end
