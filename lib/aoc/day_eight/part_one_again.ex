defmodule Aoc.DayEight.PartOneAgain do
  def part1(input) do
    solve(input, &get_antinodes_p1/2)
  end

  def solve(input, get_antinodes) do
    map = parse(input)

    map
    |> Enum.reject(fn {_pos, char} -> char === ?. end)
    |> Enum.group_by(fn {_pos, char} -> char end, fn {pos, _char} -> pos end)
    |> Enum.flat_map(fn {_char, positions} -> pairs(positions) end)
    |> Enum.flat_map(fn pair -> get_antinodes.(map, pair) end)
    |> Enum.uniq()
    |> length()
  end

  def get_antinodes_p1(map, {{y, x}, {y2, x2}}) do
    y_diff = y - y2
    x_diff = x - x2

    [{y + y_diff, x + x_diff}, {y2 - y_diff, x2 - x_diff}]
    |> Enum.reject(fn pos -> Map.get(map, pos) === nil end)
  end

  def pairs([_]), do: []

  def pairs([head | tail]) do
    Enum.flat_map(tail, &[{head, &1}]) ++ pairs(tail)
  end

  def parse(stream) do
    stream
    |> Stream.with_index()
    |> Stream.flat_map(fn {line, row_nr} ->
      line
      |> String.trim_trailing()
      |> String.to_charlist()
      |> Stream.with_index()
      |> Stream.flat_map(fn {char, col_nr} ->
        position = {row_nr, col_nr}
        [{position, char}]
      end)
    end)
    |> Enum.into(%{})
  end
end
