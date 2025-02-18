defmodule Aoc.DaySix.PartOne do
  def compute_tiles() do
    parse_file()
    |> parse_initial_map()
    |> simulate()
  end

  def simulate(map) do
    simulate(map, [], MapSet.new())
  end

  def simulate({map, guard}, path, set) do
    path = [guard | path]
    set = MapSet.put(set, guard)

    next_position = next({map, guard})

    if is_nil(next_position) do
      {:ok, path}
    else
      if MapSet.member?(set, next_position) do
        {:loop, path}
      else
        simulate({map, next_position}, path, set)
      end
    end
  end

  def next({map, {position, direction} = guard}) do
    next_position = get_next_position(guard)

    case Map.get(map, next_position) do
      ?. -> {next_position, direction}
      ?\# -> {position, rotate_right(direction)}
      nil -> nil
    end
  end

  def get_next_position({{y, x}, {a, b}}), do: {y + a, x + b}

  def rotate_right(direction) do
    case direction do
      {-1, 0} -> {0, 1}
      {0, 1} -> {1, 0}
      {1, 0} -> {0, -1}
      {0, -1} -> {-1, 0}
    end
  end

  def parse_file() do
    Path.join(["priv", "aoc", "day_six.txt"])
    |> File.stream!()
  end

  def parse_initial_map(stream) do
    map =
      stream
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row_nr} ->
        line
        |> String.trim()
        |> String.to_charlist()
        |> Enum.with_index()
        |> Enum.flat_map(fn {char, col_nr} ->
          coordinates = {row_nr, col_nr}
          [{coordinates, char}]
        end)
      end)
      |> Map.new()

    {guard_coordinates, _} = Enum.find(map, fn {_, c} -> c === ?^ end)
    map_without_guard = Map.put(map, guard_coordinates, ?.)
    direction = {-1, 0}
    guard = {guard_coordinates, direction}
    {map_without_guard, guard}
  end
end
