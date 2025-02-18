defmodule Aoc.DaySix.PartTwo do
  import Aoc.DaySix.PartOne

  def computes_number_of_loops() do
    parse_file()
    |> parse_initial_map()
    |> count_loops()
  end

  def count_loops({_, {initial_pos, _dir}} = map) do
    :persistent_term.put(Aoc.DaySix.PartTwo, map)

    {:ok, reversed_path} = simulate(map)

    reversed_path
    |> Enum.reject(fn {pos, _} -> pos === initial_pos end)
    |> Enum.map(fn {pos, _} -> pos end)
    |> Enum.uniq()
    |> Task.async_stream(
      fn pos ->
        {initial_map, guard} = :persistent_term.get(Aoc.DaySix.PartTwo)
        new_map = Map.put(initial_map, pos, ?\#)

        case simulate({new_map, guard}) do
          {:ok, _} -> 0
          {:loop, _} -> 1
        end
      end,
      ordered: false
    )
    |> Enum.reduce(0, fn {:ok, x}, acc -> x + acc end)
  end
end
