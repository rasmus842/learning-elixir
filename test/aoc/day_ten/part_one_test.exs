defmodule Aoc.DayTen.PartOneTest do
  use ExUnit.Case
  import Aoc.DayTen.PartOne

  @test_grid """
             0123
             1234
             8765
             9876
             """
             |> String.split("\n")

  test "Parses grid" do
    grid = parse_grid(@test_grid)
    assert Map.fetch!(grid, {3, 3}) == 6
  end

  test "Get reachable summits from position" do
    grid = parse_grid(@test_grid)

    assert get_reachable_summits(grid, {{2, 0}, 8}) == [{3, 0}]
  end

  test "Calculates score for test grid" do
    score = @test_grid |> parse_grid() |> get_trailhead_scores()

    assert score == 1
  end

  test "Calculates total trailhead score" do
    total =
      Path.join(["priv", "aoc", "day_ten.txt"])
      |> File.stream!()
      |> parse_grid()
      |> get_trailhead_scores()

    assert total == 798
  end
end
