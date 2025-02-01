defmodule Aoc.DayTwo.PartOne do
  def red_nosed_reports do
    Path.join(["priv", "aoc", "day_two.txt"])
    |> File.stream!()
    |> Enum.filter(&is_safe?/1)
    |> Enum.count()
  end

  def is_safe?(line) do
    result =
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> check_is_safe?()

    IO.puts("Numbers=[#{String.trim(line)}], #{result}")
    result
  end

  defp check_is_safe?(numbers) do
    case Enum.reduce_while(numbers, {nil, nil}, &checkSafetyReducer/2) do
      {nil, result} -> result
      _ -> true
    end
  end

  defp checkSafetyReducer(new_element, {nil, nil}) do
    {:cont, {new_element, nil}}
  end

  defp checkSafetyReducer(new_element, {prev_element, nil}) do
    {:cont, {new_element, calculate_diff(prev_element, new_element)}}
  end

  defp checkSafetyReducer(_new_element, {_prev_element, :unSafe}) do
    unsafe()
  end

  defp checkSafetyReducer(new_element, {prev_element, prev_diff}) do
    case {prev_diff, calculate_diff(prev_element, new_element)} do
      {:increasing, :decreasing} -> unsafe()
      {:decreasing, :increasing} -> unsafe()
      {_prev_diff, new_diff} -> {:cont, {new_element, new_diff}}
    end
  end

  defp calculate_diff(prev_element, new_element) do
    case new_element - prev_element do
      diff when diff > 3 or diff == 0 ->
        :unSafe

      diff when diff > 0 ->
        :increasing

      diff when diff < 0 ->
        :decreasing
    end
  end

  defp unsafe do
    {:halt, {nil, false}}
  end
end
