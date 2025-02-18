defmodule Aoc.DayFour.PartOneTest do
  use ExUnit.Case
  import Aoc.DayFour.PartOne

  @matrix {
    {1, 2, 3, 4},
    {5, 6, 7, 8, 9},
    {10},
    {11, 12, 13}
  }

  test "parses xmas string into tuple" do
    tuple = line_to_number_tuple("XMASooooMXMo")
    assert tuple == {1, 2, 3, 4, 0, 0, 0, 0, 2, 1, 2, 0}
  end

  test "gets element at" do
    element = element_at(@matrix, {2, 0})
    assert element == 10
  end

  test "returns nil for out of bounds" do
    element = element_at(@matrix, {2, 1})
    assert element == nil
  end

  test "gets next coordinates" do
    assert get_next_coordinates(:north, {1, 1}) == {0, 1}
    assert get_next_coordinates(:north_east, {1, 1}) == {0, 2}
    assert get_next_coordinates(:east, {1, 1}) == {1, 2}
    assert get_next_coordinates(:south_east, {1, 1}) == {2, 2}
    assert get_next_coordinates(:south, {1, 1}) == {2, 1}
    assert get_next_coordinates(:south_west, {1, 1}) == {2, 0}
    assert get_next_coordinates(:west, {1, 1}) == {1, 0}
    assert get_next_coordinates(:north_west, {1, 1}) == {0, 0}
  end

  test "east has xmas" do
    matrix = {
      {1, 2, 3, 4}
    }

    is_xmas = xmas?(:east, 1, {0, 0}, matrix)
    assert is_xmas == true
  end

  test "counts xmas correctly" do
    matrix = {
      {0, 0, 1, 2, 3, 4, 1, 4},
      {1, 0, 2, 0, 0, 3, 3, 0},
      {2, 2, 3, 0, 0, 2, 2, 2},
      {3, 0, 3, 0, 1, 1, 0, 0, 1},
      {4, 0, 0, 4, 0, 0, 0, 0, 0}
    }

    assert count_xmas(matrix) == 6
  end

  test "completes part one" do
    xmas_count = read_xmas()
    assert xmas_count == 2483
  end
end
