defmodule Mealy.Meals.MealsControllerTest do
  use MealyWeb.ConnCase, async: true
  import Mealy.Factory

  describe "create/2" do
    test "When all parameters are valid, creates the meal", %{conn: conn} do
      params = %{
        calories: "30.0",
        description: "coalhada",
        date: "2021-03-28T21:15:42.627Z"
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      expected_response = %{
        "message" => "Meal created!",
        "meal" => %{
          "calories" => 30.0,
          "description" => "coalhada",
          "date" => ~N[2021-02-16 22:00:00]
        }
      }

      assert expected_response = response
    end
  end

  describe "show/2" do
    test "If the user exists returns the user", %{conn: conn} do
      meal = build(:meal)
      insert(meal)

      response =
        conn
        |> get(Routes.meals_path(conn, :show, meal.id))
        |> json_response(:ok)

      expected_response = %{
        "meal" => %{
          "calories" => 30.0,
          "description" => "coalhada",
          "date" => ~N[2021-02-16 22:00:00]
        }
      }

      assert expected_response = response
    end
  end

  describe "update/2" do
    test "If parameters are valid, updates the user", %{conn: conn} do
      meal = build(:meal)
      insert(meal)

      params = %Mealy.Meal{
        id: meal.id,
        date: meal.date,
        description: "banana frita",
        calories: "20.0"
      }

      response =
        conn
        |> put(Routes.meals_path(conn, :update, params))
        |> json_response(:accepted)

      expected_response = %{
        "meal" => %{
          "calories" => 20.0,
          "description" => "banana frita",
          "date" => ~N[2021-02-16 22:00:00]
        }
      }

      assert expected_response = response
    end
  end

  describe "delete/2" do
    test "If the user exists, deletes the user", %{conn: conn} do
      meal = build(:meal)
      insert(meal)

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, meal.id))
        |> response(:no_content)

      assert "" = response
    end
  end
end
