defmodule Aoc.DayFour.PartTwo do
  import Aoc.DayFour.PartOne

  def read_xmas_corretly() do
    parse()
    |> count_xmas_correctly()
  end

  def count_xmas_correctly(matrix) do
    0..(tuple_size(matrix) - 1)
    |> Enum.map(&count_xmas_correctly_for_row(matrix, &1))
    |> Enum.sum()
  end

  def count_xmas_correctly_for_row(matrix, row_nr) do
    row = elem(matrix, row_nr)

    0..(tuple_size(row) - 1)
    |> Enum.filter(&correct_xmas?(matrix, {row_nr, &1}))
    |> Enum.count()
  end

  def correct_xmas?(matrix, coordinates) do
    case element_at(matrix, coordinates) do
      3 -> nw_se_correct?(matrix, coordinates) and ne_sw_correct?(matrix, coordinates)
      e when e in [0, 1, 2, 4] -> false
    end
  end

  def nw_se_correct?(matrix, coordinates) do
    nw = element_at(matrix, coordinates, :north_west)
    se = element_at(matrix, coordinates, :south_east)
    diagonal_correct?(nw, se)
  end

  def ne_sw_correct?(matrix, coordinates) do
    ne = element_at(matrix, coordinates, :north_east)
    sw = element_at(matrix, coordinates, :south_west)
    diagonal_correct?(ne, sw)
  end

  def diagonal_correct?(x, y) do
    case {x, y} do
      {nil, _} -> false
      {_, nil} -> false
      {2, 4} -> true
      {4, 2} -> true
      _ -> false
    end
  end
end
