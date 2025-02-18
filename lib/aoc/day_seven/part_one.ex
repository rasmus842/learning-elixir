defmodule Aoc.DaySeven.PartOne do
  def complete_part_one() do
    parse_and_compute(fn x, y -> [x + y, x * y] end)
  end

  def parse_and_compute(expander) do
    Path.join(["priv", "aoc", "day_seven.txt"])
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&is_correct?(&1, expander))
    |> Enum.sum_by(fn {result, _} -> result end)
  end

  def parse_line(line) do
    [result, nums | []] =
      line
      |> String.split(":")

    nums_list =
      nums
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(result), nums_list}
  end

  def is_correct?({result, nums}, expander) do
    nums
    |> get_possible_results(expander)
    |> Enum.any?(&(&1 === result))
  end

  def get_possible_results(nums, expander) do
    nums
    |> Enum.reduce([], &expand_possible_results(&1, &2, expander))
    |> Enum.uniq()
  end

  def expand_possible_results(x, results, expander) do
    if Enum.empty?(results) do
      [x]
    else
      Enum.flat_map(results, &expander.(&1, x))
    end
  end
end
