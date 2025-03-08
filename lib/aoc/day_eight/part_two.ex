defmodule Aoc.DayEight.PartTwo do
  import Aoc.DayEight.PartOneAgain

  def part2(input) do
    solve(input, &get_antinodes_p2/2)
  end

  def get_antinodes_p2(map, {{y, x}, {y2, x2}}) do
    y_diff = y - y2
    x_diff = x - x2
    diff = {y_diff, x_diff}

    get_inline_antinodes(map, {y, x}, diff, &next_sum/2) ++
      get_inline_antinodes(map, {y2, x2}, diff, &next_sub/2)
  end

  def get_inline_antinodes(map, pos, diff, get_next) do
    infinite_stream()
    |> Enum.reduce_while({[pos], pos}, fn _n, {nodes, last_pos} ->
      next_pos = get_next.(last_pos, diff)

      case Map.get(map, next_pos) do
        nil -> {:halt, nodes}
        _ -> {:cont, {[next_pos | nodes], next_pos}}
      end
    end)
  end

  def next_sum({y, x}, {y_diff, x_diff}), do: {y + y_diff, x + x_diff}

  def next_sub({y, x}, {y_diff, x_diff}), do: {y - y_diff, x - x_diff}

  def infinite_stream() do
    Stream.unfold(0, fn n -> {n, n + 1} end)
  end
end
