defmodule Aoc.DayTen.PartOne do
  @directions [:up, :down, :left, :right]

  def get_trailhead_scores(grid) do
    grid
    |> Stream.filter(fn {_pos, height} -> height == 0 end)
    |> Enum.map(fn {pos, height} -> get_score(grid, {pos, height}) end)
    |> Enum.sum()
  end

  def get_score(grid, {pos, 0}) do
    get_reachable_summits(grid, {pos, 0})
    |> Enum.uniq()
    |> Enum.count()
  end

  def get_reachable_summits(_grid, {pos, 9}), do: [pos]

  def get_reachable_summits(grid, {pos, height}) do
    @directions
    |> Enum.flat_map(fn dir -> get_reachable_summits(grid, {pos, height}, dir) end)
  end

  def get_reachable_summits(grid, {pos, height}, direction) do
    next_pos = next_position(pos, direction)

    case Map.get(grid, next_pos) do
      nil -> []
      next when next == height + 1 -> get_reachable_summits(grid, {next_pos, next})
      _ -> []
    end
  end

  def next_position({y, x}, direction) do
    case direction do
      :up -> {y - 1, x}
      :down -> {y + 1, x}
      :left -> {y, x - 1}
      :right -> {y, x + 1}
    end
  end

  def parse_grid(input) do
    input
    |> Stream.with_index()
    |> Stream.flat_map(fn {row, row_nr} ->
      row
      |> String.trim()
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.flat_map(fn {height, col_nr} ->
        position = {row_nr, col_nr}
        [{position, ascii_to_digit(height)}]
      end)
    end)
    |> Enum.into(%{})
  end

  def ascii_to_digit(ascii) when ascii >= 48 and ascii < 58, do: ascii - 48

  def ascii_to_digit(_ascii), do: nil
end
