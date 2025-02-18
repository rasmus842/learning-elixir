defmodule Aoc.DaySeven.PartTwoTest do
  use ExUnit.Case
  import Aoc.DaySeven.PartTwo

  test "Completes part two, concatenation using strings" do
    assert complete_part_two(&concatenate/2) == 37_598_910_447_546
  end

  test "Completes part two, concatenation using mults and divs" do
    assert complete_part_two(&concatenate_ints/2) == 37_598_910_447_546
  end
end
