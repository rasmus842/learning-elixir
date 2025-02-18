defmodule Aoc.DaySix.PartOneTest do
  use ExUnit.Case
  import Aoc.DaySix.PartOne

  @raw_map """
  ...#...
  ......#
  #..^...
  .....#.
  """

  test "parses map" do
    {parsed_map, guard} =
      @raw_map
      |> String.split("\n")
      |> parse_initial_map()

    assert guard == {{2, 3}, {-1, 0}}

    blocks = [{0, 3}, {1, 6}, {2, 0}, {3, 5}]

    for row_nr <- 0..3,
        col_nr <- 0..6 do
      position = {row_nr, col_nr}

      case Map.fetch!(parsed_map, position) do
        ?\# -> assert position in blocks
        ?. -> true
      end
    end
  end

  test "Simulates test map" do
    {result_code, path} =
      @raw_map
      |> String.split("\n")
      |> parse_initial_map()
      |> simulate()

    assert result_code === :ok

    assert Enum.reverse(path) === [
             {{2, 3}, {-1, 0}},
             {{1, 3}, {-1, 0}},
             {{1, 3}, {0, 1}},
             {{1, 4}, {0, 1}},
             {{1, 5}, {0, 1}},
             {{1, 5}, {1, 0}},
             {{2, 5}, {1, 0}},
             {{2, 5}, {0, -1}},
             {{2, 4}, {0, -1}},
             {{2, 3}, {0, -1}},
             {{2, 2}, {0, -1}},
             {{2, 1}, {0, -1}},
             {{2, 1}, {-1, 0}},
             {{1, 1}, {-1, 0}},
             {{0, 1}, {-1, 0}}
           ]
  end

  test "Finds loop" do
    {initial_map, guard} =
      @raw_map
      |> String.split("\n")
      |> parse_initial_map()

    map_with_loop = Map.put(initial_map, {2, 2}, ?\#)
    {result_code, path} = simulate({map_with_loop, guard})

    assert result_code === :loop

    assert Enum.reverse(path) === [
             {{2, 3}, {-1, 0}},
             {{1, 3}, {-1, 0}},
             {{1, 3}, {0, 1}},
             {{1, 4}, {0, 1}},
             {{1, 5}, {0, 1}},
             {{1, 5}, {1, 0}},
             {{2, 5}, {1, 0}},
             {{2, 5}, {0, -1}},
             {{2, 4}, {0, -1}},
             {{2, 3}, {0, -1}}
           ]
  end
end
