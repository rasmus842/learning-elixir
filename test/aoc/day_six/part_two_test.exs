defmodule Aoc.DaySix.PartTwoTest do
  use ExUnit.Case
  import Aoc.DaySix.PartTwo
  import Aoc.DaySix.PartOne, only: [parse_initial_map: 1]

  @raw_map """
  ...#...
  ......#
  #..^...
  .....#.
  """

  test "Correctly counts loops for test map" do
    count =
      @raw_map
      |> String.split("\n")
      |> parse_initial_map()
      |> count_loops()

    assert count == 2
  end

  test "Completes part two" do
    count = computes_number_of_loops()
    assert count == 1984
  end
end
