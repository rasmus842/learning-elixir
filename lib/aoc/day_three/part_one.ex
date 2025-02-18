defmodule Aoc.DayThree.PartOne do
  def compute_result() do
    Path.join(["priv", "aoc", "day_three.txt"])
    |> File.stream!()
    |> Enum.flat_map(&to_multiplications/1)
    |> Enum.sum_by(&multiply/1)
  end

  def to_multiplications(line) do
    regex = ~r/mul\(([\d]+),([\d]+)\)/

    for [num1, num2] <- Regex.scan(regex, line, capture: :all_but_first) do
      {String.to_integer(num1), String.to_integer(num2)}
    end
  end

  def multiply({num1, num2}), do: num1 * num2
end
