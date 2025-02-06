defmodule Aoc.DayTwo.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayTwo.PartTwo

  @test_data [
    {"1 2 3 4 5", true},
    {"1 2 2 3 4", true},
    {"1 1 1 2 4", false},
    {"1 2 3 2", true},
    {"1 2 3 2 3", false},
    {"5 4 3 2 1", true},
    {"1 2 3 20 22", false},
    {"1 2 3 20 ", true},
    {"13 16 19 22 24 25 25", true},
    {"43 46 47 48 50 52 56", true},
    {"43 46 47 48 50 52 56 57", false},
    {"43 46 45 48 50 52", true},
    {"43 46 0 48 50 52", true},
    {"43 46 0 2 48 50 52", false}
  ]

  for {report, is_safe} <- @test_data do
    test "Test #{report}, is_safe=#{is_safe}" do
      numbers = unquote(report) |> String.split() |> Enum.map(&String.to_integer/1)
      assert safe?(numbers) == unquote(is_safe)
    end
  end

  test "Completes Aoc.DayTwo.PartTwo" do
    count = red_nosed_reports()
    assert count == 324
  end
end
