defmodule Aoc.DaySeven.PartTwo do
  import Aoc.DaySeven.PartOne, only: [parse_and_compute: 1]

  def complete_part_two(concatenation_strategy) do
    parse_and_compute(fn x, y ->
      [x + y, x * y, concatenation_strategy.(x, y)]
    end)
  end

  def concatenate(x, y) do
    (Integer.to_string(x) <> Integer.to_string(y))
    |> String.to_integer()
  end

  def concatenate_ints(x, y) do
    shift_int(x, y) + y
  end

  def shift_int(x, 0), do: x
  def shift_int(x, y), do: shift_int(x * 10, div(y, 10))
end
