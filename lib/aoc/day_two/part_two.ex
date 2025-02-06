defmodule Aoc.DayTwo.PartTwo do
  def red_nosed_reports do
    Path.join(["priv", "aoc", "day_two.txt"])
    |> Aoc.DayTwo.PartOne.parse()
    |> Enum.filter(&safe?/1)
    |> Enum.count()
  end

  def safe?(numbers) do
    Aoc.DayTwo.PartOne.safe?(numbers) or
      0..(length(numbers) - 1)
      |> Enum.map(fn i -> List.delete_at(numbers, i) end)
      |> Enum.any?(&Aoc.DayTwo.PartOne.safe?/1)
  end
end
