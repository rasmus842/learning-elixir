defmodule Aoc.DayTwo.PartOne do
  def red_nosed_reports do
    Path.join(["priv", "aoc", "day_two.txt"])
    |> parse()
    |> Enum.filter(&safe?/1)
    |> Enum.count()
  end

  def parse(path) do
    File.stream!(path)
    |> Enum.map(&line_to_numbers/1)
  end

  defp line_to_numbers(line) do
    String.split(line) |> Enum.map(&String.to_integer/1)
  end

  def safe?(numbers) do
    case Enum.reduce_while(numbers, {nil, nil}, &checkSafetyReducer/2) do
      {_last_element, nil} -> true
      {_last_element, :unSafe} -> false
      {_last_element, _safe} -> true
    end
  end

  defp checkSafetyReducer(new_element, {prev_element, prev_diff}) do
    case {prev_element, prev_diff} do
      {nil, nil} ->
        {:cont, {new_element, nil}}

      {_prev, :unSafe} ->
        unsafe()

      _ ->
        calculate_diff_and_check_is_safe(new_element, {prev_element, prev_diff})
    end
  end

  defp calculate_diff_and_check_is_safe(new_element, {prev_element, prev_diff}) do
    case {prev_diff, calculate_diff(prev_element, new_element)} do
      {nil, new_diff} -> {:cont, {new_element, new_diff}}
      {:increasing, :decreasing} -> unsafe()
      {:decreasing, :increasing} -> unsafe()
      {_prev_diff, new_diff} -> {:cont, {new_element, new_diff}}
    end
  end

  defp calculate_diff(prev_element, new_element) do
    case new_element - prev_element do
      diff when abs(diff) > 3 or diff == 0 ->
        :unSafe

      diff when diff > 0 ->
        :increasing

      diff when diff < 0 ->
        :decreasing
    end
  end

  def unsafe, do: {:halt, {nil, :unSafe}}
end
