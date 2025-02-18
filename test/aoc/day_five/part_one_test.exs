defmodule Aoc.DayFive.PartOneTest do
  use ExUnit.Case
  import Aoc.DayFive.PartOne

  @rules %{
    1 => [10, 11],
    2 => [1, 3],
    10 => [3, 11]
  }

  test "Correctly assesses contradiction" do
    assert rule_contradiction?({1, 2}, %{2 => [1]})
    assert rule_contradiction?({3, 10}, %{2 => [1], 10 => [3]})
  end

  test "Correctly assesses no contradiction" do
    assert not rule_contradiction?({1, 2}, %{})
    assert not rule_contradiction?({1, 2}, %{3 => [10]})
    assert not rule_contradiction?({1, 2}, %{1 => [3]})
  end

  test "Inserts new rule with no existing key" do
    updated = update_rules({1, 2}, %{3 => [10]})
    assert updated == %{1 => [2], 3 => [10]}
  end

  test "Insert rule to existing key" do
    updated = update_rules({1, 2}, %{1 => [3], 3 => [10]})
    assert updated == %{1 => [2, 3], 3 => [10]}
  end

  test "parses rule and passes into map" do
    result_map = parse_rule_and_save_to_map("12|32", %{})
    assert result_map == %{12 => [32]}
  end

  test "Parses an updates line" do
    update = parse_update("12,43,13,17,5\n")
    assert update == [12, 43, 13, 17, 5]
  end

  test "Correctly checks update is correct" do
    update = [2, 1, 10, 3, 11]
    assert update_correct?(update, @rules)
  end

  test "Correctly checks update is incorrect" do
    update = [2, 10, 1, 3, 11]
    assert not update_correct?(update, @rules)
  end

  test "Completes part one" do
    assert compute_result() == 5087
  end
end
