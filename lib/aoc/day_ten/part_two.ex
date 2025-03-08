defmodule Aoc.DayTen.PartTwo do
  import Aoc.DayTen.PartOne

  def get_trailhead_ratings(grid) do
    grid
    |> Stream.filter(fn {_pos, height} -> height == 0 end)
    |> Enum.map(fn {pos, height} -> get_rating(grid, {pos, height}) end)
    |> Enum.sum()
  end

  def get_rating(grid, {pos, 0}) do
    get_distinct_paths(grid, {pos, 0})
  end

  def get_distinct_paths(_grid, {_pos, 9}), do: 1

  def get_distinct_paths(grid, {pos, height}) do
    [:up, :down, :left, :right]
    |> Enum.sum_by(fn dir -> get_distinct_paths(grid, {pos, height}, dir) end)
  end

  def get_distinct_paths(grid, {pos, height}, direction) do
    next_pos = next_position(pos, direction)

    case Map.get(grid, next_pos) do
      nil -> 0
      next when next == height + 1 -> get_distinct_paths(grid, {next_pos, next})
      _ -> 0
    end
  end
end
