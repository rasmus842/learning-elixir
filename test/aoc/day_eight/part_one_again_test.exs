defmodule Aoc.DayEight.PartOneAgainTest do
  use ExUnit.Case
  import Aoc.DayEight.PartOneAgain

  @map_x """
         ..132sd..dd.ca.s
         ..1..3..dfs.as.1
         ..213d.a.32.asd.
         .dsdf.1.21.f.sd.
         ................
         ..1..3..dfs.as.1
         ..213d.a.32.asd.
         .dsdf.1.21.f.sd.
         ......1.........
         ................
         ................
         """
         |> String.split("\n")

  @test_map """
            ....3..
            ..1..3.
            ..1..a.
            .1..a..
            .......
            """
            |> String.split("\n")

  @another_test_map """
                    ............
                    ........0...
                    .....0......
                    .......0....
                    ....0.......
                    ......A.....
                    ............
                    ............
                    ........A...
                    .........A..
                    ............
                    ............
                    """
                    |> String.split("\n")

  @and_another_test_map """
                        ..........
                        ..........
                        ..........
                        ....a.....
                        ........a.
                        .....a....
                        ..........
                        ......A...
                        ..........
                        ..........
                        """
                        |> String.split("\n")

  test "Test parsing of maps" do
    map =
      """
      ..a
      .a.
      .11
      """
      |> String.split("\n")
      |> parse()

    assert map == %{
             {0, 0} => ?.,
             {0, 1} => ?.,
             {0, 2} => ?a,
             {1, 0} => ?.,
             {1, 1} => ?a,
             {1, 2} => ?.,
             {2, 0} => ?.,
             {2, 1} => ?1,
             {2, 2} => ?1
           }
  end

  test "Get number of anti nodes" do
    assert part1(@test_map) == 7
    assert part1(@another_test_map) == 14
    assert part1(@and_another_test_map) == 4
  end

  test "Solve part one" do
    input =
      Path.join(["priv", "aoc", "day_eight.txt"])
      |> File.stream!()

    assert part1(input) == 278
  end

  test "Try to see differences between first try and second try" do
    input =
      Path.join(["priv", "aoc", "day_eight.txt"])
      |> File.stream!()

    first_antinodes =
      first_solution_anti_nodes(input)
      |> Enum.into(%MapSet{})

    second_antinodes =
      second_solution_anti_nodes(input)
      |> Enum.into(%MapSet{})

    diff = MapSet.difference(second_antinodes, first_antinodes)

    assert diff == MapSet.new([{49, 32}, {49, 37}])
  end

  defp second_solution_anti_nodes(input) do
    map = parse(input)

    map
    |> Enum.reject(fn {_pos, char} -> char === ?. end)
    |> Enum.group_by(fn {_pos, char} -> char end, fn {pos, _char} -> pos end)
    |> Enum.flat_map(fn {_har, positions} -> pairs(positions) end)
    |> Enum.flat_map(fn pos -> get_antinodes_p1(map, pos) end)
    |> Enum.uniq()
  end

  defp first_solution_anti_nodes(input) do
    {map, {max_y, max_x}} = Aoc.DayEight.PartOne.parse(input)

    map
    |> Enum.flat_map(fn {_char, positions} ->
      positions
      |> Aoc.DayEight.PartOne.pairs()
      |> Enum.flat_map(fn {{y, x}, {y2, x2}} ->
        y_diff = y - y2
        x_diff = x - x2

        [{y + y_diff, x + x_diff}, {y2 - y_diff, x2 - x_diff}]
      end)
    end)
    |> Enum.reject(fn {y, x} ->
      y < 0 or x < 0 or y > max_y or x > max_x
    end)
    |> Enum.uniq()
  end
end
