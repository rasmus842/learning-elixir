defmodule Aoc.DayFive.PartOne do
  def compute_result do
    rules = parse_rules()

    parse_updates()
    |> Stream.filter(&(not Enum.empty?(&1)))
    |> Stream.filter(&update_correct?(&1, rules))
    |> Stream.map(&Enum.at(&1, div(length(&1), 2)))
    |> Enum.sum()
  end

  def update_correct?([], _rules), do: true
  def update_correct?([_last_element], _rules), do: true

  def update_correct?([current_number | numbers_after], rules) do
    number_correct?(current_number, numbers_after, rules) and
      update_correct?(numbers_after, rules)
  end

  def number_correct?(current_number, numbers_after, rules) do
    Enum.all?(numbers_after, fn number_after ->
      case Map.get(rules, number_after) do
        nil ->
          true

        numbers_that_must_be_after ->
          not Enum.member?(numbers_that_must_be_after, current_number)
      end
    end)
  end

  def parse_updates do
    Path.join(["priv", "aoc", "day_five", "updates.txt"])
    |> File.stream!()
    |> Stream.map(&parse_update/1)
  end

  def parse_update(line) do
    String.split(line, ",")
    |> Enum.map(&(String.trim(&1) |> String.to_integer()))
  end

  def parse_rules do
    Path.join(["priv", "aoc", "day_five", "rules.txt"])
    |> File.stream!()
    |> Enum.reduce(%{}, &parse_rule_and_save_to_map/2)
  end

  def parse_rule_and_save_to_map(rule, map) do
    Regex.run(~r/([\d]+)\|([\d]+)/, rule, capture: :all_but_first)
    |> to_int_pair()
    |> update_rules(map)
  end

  def to_int_pair([a, b]) do
    {String.to_integer(a), String.to_integer(b)}
  end

  def update_rules(rule = {a, b}, map) do
    if rule_contradiction?(rule, map) do
      raise "Contradiction with rules, #{a} must be after #{b}, but got new rule #{a}|#{b}"
    else
      Map.update(map, a, [b], fn existing_rules ->
        [b | existing_rules]
      end)
    end
  end

  def rule_contradiction?({a, b}, map) do
    case Map.get(map, b) do
      nil -> false
      after_b when is_list(after_b) -> Enum.any?(after_b, &(&1 === a))
    end
  end
end
