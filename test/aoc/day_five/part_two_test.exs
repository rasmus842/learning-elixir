defmodule Aoc.DayFive.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayFive.PartTwo

  @rules %{
    1 => [10, 11],
    2 => [1, 3],
    10 => [3, 11]
  }

  test "Correct update stays same" do
    update = [2, 1, 10, 3, 11]
    corrected_update = Enum.sort(update, get_sorter(@rules))
    assert corrected_update == update
  end

  test "Corrects update" do
    update = [2, 10, 1, 3, 11]
    corrected_update = Enum.sort(update, get_sorter(@rules))
    assert corrected_update == [2, 1, 10, 3, 11]
  end

  test "Completes part two" do
    assert compute_result_while_correcting_updates() == 4971
  end
end
