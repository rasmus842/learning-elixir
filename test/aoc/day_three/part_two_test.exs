defmodule Aoc.DayThree.PartTwoTest do
  use ExUnit.Case
  alias Aoc.DayThree.PartTwo

  test "parses line to multiplicaltions" do
    mults =
      ["adsfdo()dsafmul(2,3)3242.;;'mul(3;,4)ads'amul(2,5)adsdon't()asmul(1,1)"]
      |> Enum.flat_map(&PartTwo.to_multiplications/1)

    assert mults = [:do, {2, 3}, {2, 5}, :donot]
  end

  test "sums up multiplications" do
    sum =
      ["adsfddo()safmul(2,3)3242.;;'mul(3;,4)addon't()adsfmul(1,1)s'do()amul(2,5)"]
      |> PartTwo.calculate_multiplications()

    assert sum == 16
  end

  test "Completes first part" do
    result = PartTwo.compute_result()
    assert result == 75_920_122
  end
end
