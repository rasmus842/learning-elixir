defmodule Aoc.DayTwo.PartOneTest do
  use ExUnit.Case
  import Aoc.DayTwo.PartOne

  defp is_safe?(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> safe?()
  end

  test "Increasing report is safe" do
    assert is_safe?("1 2 3 4 5") == true
  end

  test "Decreasing report is safe" do
    assert is_safe?("5 4 3 2 1") == true
  end

  test "Big diff report is unsafe" do
    assert is_safe?("1 2 3 20 22") == false
  end

  test "0 diff report is unsafe" do
    assert is_safe?("1 2 2 3 4") == false
  end

  test "increasing then decreasing is unsafe" do
    assert is_safe?("1 2 2 3 2") == false
  end

  test "Inversion is unsafe" do
    assert is_safe?("1 2 3 2 4") == false
  end

  test "Completes Red-Nosed Reports" do
    count = red_nosed_reports()
    assert count == 252
  end

  @test_data [
    {"13 16 19 22 24 25 25", false},
    {"43 46 47 48 50 52 56", false},
    {"55 57 60 61 64 65 68 74", false}
  ]

  for {report, is_safe} <- @test_data do
    test "Test #{report}, is_safe=#{is_safe}" do
      assert is_safe?(unquote(report)) == unquote(is_safe)
    end
  end
end
