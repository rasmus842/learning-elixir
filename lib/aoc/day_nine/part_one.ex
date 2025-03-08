defmodule Aoc.DayNine.PartOne do
  def reorder_file_system(file_system) do
    fs_map = file_system_as_map(file_system)
    fs_size = map_size(fs_map)
    free_pos = get_next_free_pos(fs_map, -1, fs_size)

    {_, reordered_fs_map} =
      (fs_size - 1)..0//-1
      |> Enum.reduce_while({free_pos, fs_map}, fn
        right, {left, map} when right <= left ->
          {:halt, {nil, map}}

        right, {left, map} ->
          case Map.get(map, right) do
            -1 ->
              {:cont, {left, map}}

            _x ->
              new_map = reorder(map, left, right)
              new_free_pos = get_next_free_pos(new_map, left, fs_size)
              {:cont, {new_free_pos, new_map}}
          end
      end)

    convert_fs_map_to_list(reordered_fs_map)
  end

  def calculate_checksum(file_system) do
    file_system
    |> Enum.with_index()
    |> Enum.sum_by(fn
      {-1, _i} -> 0
      {f_id, i} -> f_id * i
    end)
  end

  def reorder(map, left, right) do
    left_val = Map.get(map, left)
    right_val = Map.get(map, right)
    Map.merge(map, %{left => right_val, right => left_val})
  end

  def get_next_free_pos(fs_map, last_f_space_pos, size) do
    (last_f_space_pos + 1)..(size - 1)
    |> Enum.find(fn pos ->
      case Map.get(fs_map, pos) do
        -1 -> true
        _x -> false
      end
    end)
  end

  def parse(input) do
    {file_system, {_last_file_id, _last_mode}} =
      input
      |> String.trim()
      |> String.to_charlist()
      |> Stream.map(&ascii_to_digit/1)
      |> Enum.flat_map_reduce({0, :file}, &parse_nr/2)

    file_system
  end

  def ascii_to_digit(ascii) when ascii >= 48 and ascii < 58 do
    ascii - 48
  end

  def ascii_to_digit(_), do: :NaN

  def parse_nr(0, {curr_id, :free}), do: {[], {curr_id, :file}}

  def parse_nr(nr, {curr_id, :free}) do
    free_spaces = 0..(nr - 1) |> Enum.map(fn _ -> -1 end)
    {free_spaces, {curr_id, :file}}
  end

  def parse_nr(nr, {curr_id, :file}) do
    file_spaces = 0..(nr - 1) |> Enum.map(fn _ -> curr_id end)
    {file_spaces, {curr_id + 1, :free}}
  end

  def file_system_to_string(file_system) do
    file_system
    |> Enum.map(fn
      -1 -> "."
      x -> Integer.to_string(x)
    end)
    |> List.to_string()
  end

  def file_system_as_map(file_system) do
    file_system
    |> Stream.with_index()
    |> Stream.map(fn {file_id, i} ->
      {i, file_id}
    end)
    |> Enum.into(%{})
  end

  def convert_fs_map_to_list(fs_map) do
    fs_map
    |> Enum.map(fn {k, v} -> {k, v} end)
    |> Enum.sort_by(fn {pos, _v} -> pos end, :asc)
    |> Enum.map(fn {_pos, v} -> v end)
  end
end
