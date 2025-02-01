defmodule Aoc.DayOne.PartOneTest do
  use ExUnit.Case
  import Aoc.DayOne.PartOne

  test "maps line into tuple" do
    assert {3, 15} = map_line_into_tuple("3 15\n")
  end

  test "test_with_small_stream" do
    {first_list, second_list} =
      ["1 2\n", "3 4\n", "100 200\n", "600 800\n"]
      |> read_stream_into_tuple()

    assert [1, 3, 100, 600] = first_list
    assert [2, 4, 200, 800] = second_list
  end

  test "Calculates difference" do
    diff = calculate_difference({5, 10})
    assert diff == 5
  end

  test "Calculates and sums distances" do
    sum = calculate_and_sum_distances({[1, 3, 100, 600], [2, 4, 200, 800]})
    assert 1 + 1 + 100 + 200 == sum
  end

  test "Completes Historian Hysteria" do
    sum = historian_hysteria()
    IO.puts(sum)
    assert sum == 2_086_478
  end
end
