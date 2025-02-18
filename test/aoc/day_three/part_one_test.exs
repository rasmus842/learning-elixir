defmodule Aoc.DayThree.PartOneTest do
  use ExUnit.Case
  alias Aoc.DayThree.PartOne

  test "parses line to multiplicaltions" do
    mults =
      ["adsfdsafmul(2,3)3242.;;'mul(3;,4)ads'amul(2,5)"]
      |> Enum.flat_map(&PartOne.to_multiplications/1)

    assert mults = [{2, 3}, {2, 5}]
  end

  test "sums up multiplications" do
    sum =
      ["adsfdsafmul(2,3)3242.;;'mul(3;,4)ads'amul(2,5)"]
      |> Enum.flat_map(&PartOne.to_multiplications/1)
      |> Enum.sum_by(&PartOne.multiply/1)

    assert sum == 16
  end

  test "Completes first part" do
    result = PartOne.compute_result()
    assert result == 156_388_521
  end
end
