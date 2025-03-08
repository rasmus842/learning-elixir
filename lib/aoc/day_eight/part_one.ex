defmodule Aoc.DayEight.PartOne do
  def solve_part_one() do
    get_input()
    |> calculate_total_antinodes()
  end

  def calculate_total_antinodes(input) do
    input
    |> parse()
    |> get_antinodes()
    |> Enum.uniq()
    |> Enum.count()
  end

  def get_input() do
    Path.join(["priv", "aoc", "day_eight.txt"])
    |> File.stream!()
  end

  def get_antinodes({map, max_coords}) do
    Enum.flat_map(map, fn {_char, coordinates} ->
      get_antinodes_for_char_positions(coordinates, max_coords)
    end)
  end

  def get_antinodes_for_char_positions(coordinates, {max_y, max_x}) do
    coordinates
    |> pairs()
    |> Enum.flat_map(&compare_and_get_antinodes/1)
    |> Enum.reject(fn {y, x} ->
      y < 0 or x < 0 or y > max_y or x > max_x
    end)
    |> Enum.uniq()
  end

  def pairs([_]), do: []

  def pairs([head | tail]) do
    Enum.map(tail, &{head, &1}) ++ pairs(tail)
  end

  def compare_and_get_antinodes({{y, x}, {y2, x2}}) do
    y_diff = y - y2
    x_diff = x - x2

    [{y + y_diff, x + x_diff}, {y2 - y_diff, x2 - x_diff}]
  end

  def parse(stream) do
    [line] = Enum.take(stream, 1)
    max_x = (String.trim(line) |> String.length()) - 1

    {list, max_y} =
      stream
      |> Enum.with_index()
      |> Enum.flat_map_reduce(nil, fn {line, row_nr}, _last_row_nr ->
        new_coordinates =
          line
          |> String.trim()
          |> String.to_charlist()
          |> Enum.with_index()
          |> Enum.filter(fn {char, _col_nr} -> char !== ?. end)
          |> Enum.flat_map(fn {char, col_nr} ->
            coordinates = {row_nr, col_nr}
            [{coordinates, char}]
          end)

        {new_coordinates, row_nr - 1}
      end)

    map =
      list
      |> Enum.reduce(%{}, fn {coords, char}, map ->
        case Map.get(map, char) do
          nil -> Map.put(map, char, [coords])
          list -> Map.put(map, char, [coords | list])
        end
      end)

    {map, {max_y, max_x}}
  end
end
