defmodule Aoc.DayTen.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayTen.PartOne
  import Aoc.DayTen.PartTwo

  @test_grid_one """
                 .....0.
                 ..4321.
                 ..5..2.
                 ..6543.
                 ..7..4.
                 ..8765.
                 ..9....
                 """
                 |> String.split("\n")

  test "Gets trailhead rating" do
    grid = parse_grid(@test_grid_one)

    assert get_rating(grid, {{0, 5}, 0}) == 3
  end

  @test_grid_two """
                 ..90..9
                 ...1.98
                 ...2..7
                 6543456
                 765.987
                 876....
                 987....
                 """
                 |> String.split("\n")

  test "Gets trailhead rating for another map" do
    grid = parse_grid(@test_grid_two)

    assert get_rating(grid, {{0, 3}, 0}) == 13
  end

  @bigger_test_grid """
                    89010123
                    78121874
                    87430965
                    96549874
                    45678903
                    32019012
                    01329801
                    10456732
                    """
                    |> String.split("\n")

  test "get all trailhead ratings" do
    grid = parse_grid(@bigger_test_grid)

    assert get_trailhead_ratings(grid) == 81
  end

  test "Completes part two" do
    total =
      Path.join(["priv", "aoc", "day_ten.txt"])
      |> File.stream!()
      |> parse_grid()
      |> get_trailhead_ratings()

    assert total == 1816
  end
end
