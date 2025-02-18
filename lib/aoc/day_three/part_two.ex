defmodule Aoc.DayThree.PartTwo do
  def compute_result() do
    parse_file()
    |> calculate_multiplications()
  end

  def parse_file() do
    Path.join(["priv", "aoc", "day_three.txt"])
    |> File.stream!()
  end

  def calculate_multiplications(stream) do
    {_, sum} =
      Enum.flat_map(stream, &to_multiplications/1)
      |> Enum.reduce({:do, 0}, &multiply/2)

    sum
  end

  def to_multiplications(line) do
    regex = ~r/do\(\)|don't\(\)|mul\(([\d]+),([\d]+)\)/

    Regex.scan(regex, line)
    |> Enum.map(&handle_match/1)
  end

  defp handle_match(match) do
    case match do
      ["do()"] -> :do
      ["don't()"] -> :donot
      [_, num1, num2] -> {String.to_integer(num1), String.to_integer(num2)}
    end
  end

  def multiply(match, {:do, sum}) do
    case match do
      {num1, num2} -> {:do, sum + num1 * num2}
      :donot -> {:donot, sum}
      :do -> {:do, sum}
    end
  end

  def multiply(match, {:donot, sum}) do
    case match do
      :do -> {:do, sum}
      _ -> {:donot, sum}
    end
  end
end
