defmodule Aoc.DayFour.PartOne do
  @directions [
    :north,
    :north_east,
    :east,
    :south_east,
    :south,
    :south_west,
    :west,
    :north_west
  ]

  def read_xmas() do
    parse()
    |> count_xmas()
  end

  def parse() do
    Path.join(["priv", "aoc", "day_four.txt"])
    |> File.stream!()
    |> Enum.map(&line_to_number_tuple/1)
    |> List.to_tuple()
  end

  def line_to_number_tuple(line) do
    String.graphemes(line)
    |> Enum.map(&xmas_to_number/1)
    |> List.to_tuple()
  end

  defp xmas_to_number(char) do
    case char do
      "X" -> 1
      "M" -> 2
      "A" -> 3
      "S" -> 4
      _ -> 0
    end
  end

  def count_xmas(matrix) do
    0..(tuple_size(matrix) - 1)
    |> Enum.map(&count_xmas_for_row(&1, matrix))
    |> Enum.sum()
  end

  def count_xmas_for_row(row_nr, matrix) do
    row = elem(matrix, row_nr)

    0..(tuple_size(row) - 1)
    |> Enum.map(&count_xmas_for_element_at({row_nr, &1}, matrix))
    |> Enum.sum()
  end

  def count_xmas_for_element_at(coordinates, matrix) do
    @directions
    |> Enum.filter(&xmas?(&1, coordinates, matrix))
    |> Enum.count()
  end

  def xmas?(direction, coordinates, matrix) do
    case element_at(matrix, coordinates) do
      1 -> xmas?(direction, 1, coordinates, matrix)
      e when e in [0, 2, 3, 4] -> false
    end
  end

  def xmas?(direction, element, coordinates, matrix) do
    next_coordinates = get_next_coordinates(direction, coordinates)
    next_element = element_at(matrix, next_coordinates)

    case {element, next_element} do
      {_, 0} -> false
      {_, nil} -> false
      {3, 4} -> true
      {p, n} when n == p + 1 -> xmas?(direction, n, next_coordinates, matrix)
      _ -> false
    end
  end

  def get_next_coordinates(direction, {row_nr, col_nr}) do
    case direction do
      :north -> {row_nr - 1, col_nr}
      :north_east -> {row_nr - 1, col_nr + 1}
      :east -> {row_nr, col_nr + 1}
      :south_east -> {row_nr + 1, col_nr + 1}
      :south -> {row_nr + 1, col_nr}
      :south_west -> {row_nr + 1, col_nr - 1}
      :west -> {row_nr, col_nr - 1}
      :north_west -> {row_nr - 1, col_nr - 1}
    end
  end

  def element_at(_, {row_nr, _}) when row_nr < 0, do: nil
  def element_at(_, {_, col_nr}) when col_nr < 0, do: nil

  def element_at(matrix, {row_nr, col_nr}) do
    if row_nr >= tuple_size(matrix) do
      nil
    else
      element_at(elem(matrix, row_nr), col_nr)
    end
  end

  def element_at(row, col_nr) do
    if col_nr >= tuple_size(row) do
      nil
    else
      elem(row, col_nr)
    end
  end

  def element_at(matrix, coordinates, direction) do
    element_at(matrix, get_next_coordinates(direction, coordinates))
  end
end
