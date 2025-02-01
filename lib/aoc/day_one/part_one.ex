defmodule Aoc.DayOne.PartOne do
  def historian_hysteria do
    File.stream!("priv/aoc/aoc1.txt")
    |> read_stream_into_tuple()
    |> to_sorted_lists()
    |> calculate_and_sum_distances()
  end

  def read_stream_into_tuple(enumrable_of_strings) do
    enumrable_of_strings
    |> Enum.map(&map_line_into_tuple(&1))
    |> Enum.unzip()
  end

  def map_line_into_tuple(line) do
    String.split(line)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn {first_element, second_element} -> {first_element, second_element} end)
  end

  def to_sorted_lists({first_list, second_list}) do
    {Enum.sort(first_list), Enum.sort(second_list)}
  end

  def calculate_and_sum_distances({first_sorted_list, second_sorted_list}) do
    Enum.zip(first_sorted_list, second_sorted_list)
    |> Enum.map(&calculate_difference/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  def calculate_difference({first, second}) do
    abs(first - second)
  end
end
