defmodule Aoc.DayEight.PartOneTest do
  use ExUnit.Case
  import Aoc.DayEight.PartOne

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

  test "Parses map" do
    {map, max_coords} = @test_map |> parse()

    assert max_coords == {4, 6}

    assert map == %{
             ?3 => [{1, 5}, {0, 4}],
             ?1 => [{3, 1}, {2, 2}, {1, 2}],
             ?a => [{3, 4}, {2, 5}]
           }
  end

  test "Compares two frequencies and gets antinodes correctly" do
    # the position of two '1's in @test_map
    anti_nodes = compare_and_get_antinodes({{1, 2}, {2, 2}})
    assert anti_nodes == [{0, 2}, {3, 2}]
  end

  test "Second comparison" do
    # the position of two '1's in @test_map
    anti_nodes = compare_and_get_antinodes({{1, 2}, {3, 1}})
    assert anti_nodes == [{-1, 3}, {5, 0}]
  end

  test "Third comparison" do
    # the position of two '1's in @test_map
    anti_nodes = compare_and_get_antinodes({{2, 2}, {3, 1}})
    assert anti_nodes == [{1, 3}, {4, 0}]
  end

  test "Compares frequencies of one type and gets antinodes correctly" do
    # the position of '1's in @test_map
    anti_nodes =
      get_antinodes_for_char_positions([{1, 2}, {2, 2}, {3, 1}], {4, 6})
      |> Enum.into(%MapSet{})

    assert anti_nodes == [{3, 2}, {0, 2}, {4, 0}, {1, 3}] |> Enum.into(%MapSet{})
  end

  test "Gets all antinodes of the map" do
    anti_nodes =
      @test_map
      |> parse()
      |> get_antinodes()
      |> Enum.into(%MapSet{})

    assert anti_nodes ==
             [
               {3, 2},
               {0, 2},
               {4, 0},
               {1, 3},
               {2, 6},
               {1, 6},
               {4, 3}
             ]
             |> Enum.into(%MapSet{})
  end

  test "Count antinodes of test map" do
    count = calculate_total_antinodes(@test_map)
    assert count == 7
  end

  test "Another example map" do
    count = calculate_total_antinodes(@another_test_map)
    assert count == 14
  end

  test "And another example map" do
    count = calculate_total_antinodes(@and_another_test_map)
    assert count == 4
  end

  test "Completes part one" do
    count = solve_part_one()
    assert count == 276
  end

  test "Try my solution" do
    assert calculate_total_antinodes(@test_map) == 7
    assert calculate_total_antinodes(@another_test_map) == 14
    assert calculate_total_antinodes(@and_another_test_map) == 4

    # 276 is wrong, 278 was right for solution in PartOneAgain ???
    # might be that parsing the map something got lost?
    # or some boundary anti_node got unaccounted for?
    assert calculate_total_antinodes(get_input()) == 276
  end

  test "Completes part one using other solution" do
    solve1 = &Aoc.DayEight.PartOneAgain.part1(&1)
    assert solve1.(@test_map) == 7
    assert solve1.(@another_test_map) == 14
    assert solve1.(@and_another_test_map) == 4
    assert solve1.(get_input()) == 278
  end
end
