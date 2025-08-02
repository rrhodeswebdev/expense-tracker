defmodule ExpensetrackerWeb.ExpenseTrackerLiveTest do
  @moduledoc """
  Test the ExpenseTrackerLive page.
  """
  use ExpensetrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Expensetracker.CategoriesFixtures
  import Expensetracker.ExpensesFixtures

  describe "ExpenseTrackerLive" do
    test "displays expense tracker page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/")

      assert html =~ "Expense Tracker"
      assert html =~ "Categories"
      assert html =~ "Add Category"
      assert html =~ "Recent Expenses"
      assert html =~ "Add Expense"
    end

    test "shows category form when toggle button is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      html = lv |> element("button", "Add Category") |> render_click()

      assert html =~ "Create Category"
      assert html =~ "Name"
      assert html =~ "Description"
      assert html =~ "Monthly Budget"
    end

    test "hides category form when cancel is clicked", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      lv |> element("button", "Add Category") |> render_click()
      html = lv |> element("button", "Cancel") |> render_click()

      refute html =~ "Create Category"
    end

    test "creates a new category", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      lv |> element("button", "Add Category") |> render_click()

      html =
        lv
        |> form("form",
          category: %{
            name: "Test Category",
            description: "Test description",
            monthly_budget: "100.00"
          }
        )
        |> render_submit()

      assert html =~ "Test Category"
      assert html =~ "Test description"
      refute html =~ "Create Category"
    end

    test "validates category form", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      lv |> element("button", "Add Category") |> render_click()

      html =
        lv
        |> form("form", category: %{name: "", description: "", monthly_budget: ""})
        |> render_change()

      assert html =~ "can&#39;t be blank"
    end

    test "shows expense form when toggle button is clicked", %{conn: conn} do
      category_fixture()
      {:ok, lv, _html} = live(conn, ~p"/")

      html = lv |> element("button", "Add Expense") |> render_click()

      assert html =~ "Add Expense"
      assert html =~ "Description"
      assert html =~ "Amount"
      assert html =~ "Category"
      assert html =~ "Date"
    end

    test "creates a new expense", %{conn: conn} do
      category = category_fixture()
      {:ok, lv, _html} = live(conn, ~p"/")

      lv |> element("button", "Add Expense") |> render_click()

      html =
        lv
        |> form("[phx-submit='create_expense']",
          expense: %{
            description: "Test Expense",
            amount: "50.00",
            category_id: to_string(category.id),
            date: "2024-01-15",
            notes: "Test notes"
          }
        )
        |> render_submit()

      assert html =~ "Test Expense"
      assert html =~ "$50"
      refute html =~ "phx-submit=\"create_expense\""
    end

    test "validates expense form", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/")

      lv |> element("button", "Add Expense") |> render_click()

      html =
        lv
        |> form("form",
          expense: %{
            description: "",
            amount: "",
            category_id: "",
            date: ""
          }
        )
        |> render_change()

      assert html =~ "can&#39;t be blank"
    end

    test "toggles category expansion", %{conn: conn} do
      category = category_fixture()
      expense = expense_fixture(category_id: category.id)
      {:ok, lv, _html} = live(conn, ~p"/")

      html =
        lv
        |> element("[phx-click='toggle_category'][phx-value-id='#{category.id}']")
        |> render_click()

      assert html =~ "Expenses"
      assert html =~ expense.description
    end

    test "displays category budget progress", %{conn: conn} do
      category = category_fixture(monthly_budget: Decimal.new("100.00"))
      expense_fixture(category_id: category.id, amount: Decimal.new("75.00"))
      {:ok, lv, _html} = live(conn, ~p"/")

      html = render(lv)

      assert html =~ "$75"
      assert html =~ "$100"
      assert html =~ "75.0% used"
    end

    test "shows over-budget warning", %{conn: conn} do
      category = category_fixture(monthly_budget: Decimal.new("50.00"))
      expense_fixture(category_id: category.id, amount: Decimal.new("75.00"))
      {:ok, lv, _html} = live(conn, ~p"/")

      html = render(lv)

      assert html =~ "text-red-600"
      assert html =~ "bg-red-500"
    end

    test "displays expenses sorted by date", %{conn: conn} do
      category = category_fixture()

      expense1 =
        expense_fixture(
          category_id: category.id,
          date: ~D[2024-01-01],
          description: "First Expense"
        )

      expense2 =
        expense_fixture(
          category_id: category.id,
          date: ~D[2024-01-02],
          description: "Second Expense"
        )

      {:ok, lv, _html} = live(conn, ~p"/")

      html = render(lv)

      expense1_pos = :binary.match(html, expense1.description) |> elem(0)
      expense2_pos = :binary.match(html, expense2.description) |> elem(0)

      assert expense2_pos < expense1_pos
    end
  end
end
