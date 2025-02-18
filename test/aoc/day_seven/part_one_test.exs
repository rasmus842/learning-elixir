defmodule Aoc.DaySeven.PartOneTest do
  use ExUnit.Case
  import Aoc.DaySeven.PartOne

  test "parses line" do
    line = parse_line("123: 1 2 3\n")
    assert line == {123, [1, 2, 3]}
  end

  test "Get all possible results" do
    sum_and_product_expander = fn x, y ->
      [x + y, x * y]
    end

    possible_results = get_possible_results([1, 2, 3], sum_and_product_expander)
    assert possible_results == [6, 9, 5]
  end

  test "Computes result" do
    assert complete_part_one() == 4_998_764_814_652
  end
end
