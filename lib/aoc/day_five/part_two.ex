defmodule Aoc.DayFive.PartTwo do
  import Aoc.DayFive.PartOne

  def compute_result_while_correcting_updates do
    rules = parse_rules()
    sorter = get_sorter(rules)

    parse_updates()
    |> Stream.filter(&(not Enum.empty?(&1)))
    |> Stream.filter(&(not update_correct?(&1, rules)))
    |> Stream.map(&Enum.sort(&1, sorter))
    |> Stream.map(&Enum.at(&1, div(length(&1), 2)))
    |> Enum.sum()
  end

  def get_sorter(rules) do
    fn a, b ->
      case Map.get(rules, b) do
        nil ->
          true

        after_b ->
          not Enum.member?(after_b, a)
      end
    end
  end
end
