defmodule Aoc.DayFour.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayFour.PartTwo

  test "correct xmas" do
    matrix = {
      {2, 0, 2},
      {0, 3, 0},
      {4, 0, 4}
    }

    assert correct_xmas?(matrix, {1, 1}) == true
  end

  test "incorrect xmas out of bounds" do
    matrix = {
      {2, 0, 2},
      {0, 3, 0},
      {4, 0, 4}
    }

    assert correct_xmas?(matrix, {0, 1}) == false
  end

  test "completes part two" do
    assert read_xmas_corretly() == 1925
  end
end
