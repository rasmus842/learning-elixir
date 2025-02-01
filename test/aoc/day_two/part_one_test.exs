defmodule Aoc.DayTwo.PartOneTest do
  use ExUnit.Case
  import Aoc.DayTwo.PartOne

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

  test "0 diff report is unsafe" do
    assert is_safe?("1 2 2 3 4") == false
  end

  test "Inversion is unsafe" do
    assert is_safe?("1 2 3 2 4") == false
  end

  test "Completes Red-Nosed Reports" do
    count = red_nosed_reports()
    assert count == 366
  end
end
