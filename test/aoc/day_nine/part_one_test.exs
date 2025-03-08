defmodule Aoc.DayNine.PartOneTest do
  use ExUnit.Case
  import Aoc.DayNine.PartOne

  test "parses char to number" do
    digits =
      [?0, ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?a]
      |> Enum.map(&ascii_to_digit/1)

    assert digits == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, :NaN]
  end

  test "parses number into file" do
    {file_spaces, {next_id, :free}} = parse_nr(4, {3, :file})

    assert file_spaces == [3, 3, 3, 3]
    assert next_id = 4
  end

  test "parses no free space" do
    {free_spaces, {next_id, :file}} = parse_nr(0, {3, :free})

    assert free_spaces == []
    assert next_id = 3
  end

  test "parses number into free space" do
    {free_spaces, {next_id, :file}} = parse_nr(4, {3, :free})

    assert free_spaces == [-1, -1, -1, -1]
    assert next_id = 3
  end

  test "parses test diskmap into file system" do
    file_system =
      parse("12345")
      |> file_system_to_string()

    assert file_system == "0..111....22222"
  end

  test "parses test diskmap into file system map" do
    file_system_map = parse("12345") |> file_system_as_map()

    assert file_system_map == %{
             0 => 0,
             1 => -1,
             2 => -1,
             3 => 1,
             4 => 1,
             5 => 1,
             6 => -1,
             7 => -1,
             8 => -1,
             9 => -1,
             10 => 2,
             11 => 2,
             12 => 2,
             13 => 2,
             14 => 2
           }
  end

  test "converts fs_map back to fs" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    fs_map = file_system_as_map(fs)
    assert convert_fs_map_to_list(fs_map) == fs
  end

  test "parses another test diskmap into file system" do
    file_system =
      parse("2333133121414131402")
      |> file_system_to_string()

    assert file_system == "00...111...2...333.44.5555.6666.777.888899"
  end

  test "gets next free space position" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    fs_map = file_system_as_map(fs)
    free_pos = get_next_free_pos(fs_map, -1, map_size(fs_map))

    assert free_pos == 1
  end

  test "reorders map for given positions" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    fs_map = file_system_as_map(fs)
    size = map_size(fs_map)
    free_pos = get_next_free_pos(fs_map, -1, size)
    assert free_pos == 1

    new_map = reorder(fs_map, free_pos, size - 1)

    new_fs = convert_fs_map_to_list(new_map)
    assert file_system_to_string(new_fs) == "02.111....2222."
  end

  test "reorders test file_system" do
    file_system = parse("12345")
    assert file_system_to_string(file_system) == "0..111....22222"

    reordered_fs = reorder_file_system(file_system)

    assert file_system_to_string(reordered_fs) == "022111222......"
  end

  test "calculates checksum" do
    file_system = parse("12345")
    assert file_system_to_string(file_system) == "0..111....22222"

    assert calculate_checksum(file_system) == 132

    reordered_fs = reorder_file_system(file_system)

    assert file_system_to_string(reordered_fs) == "022111222......"

    assert calculate_checksum(reordered_fs) == 60
  end

  test "Completes part one" do
    checksum =
      Path.join(["priv", "aoc", "day_nine.txt"])
      |> File.read!()
      |> parse()
      |> reorder_file_system()
      |> calculate_checksum()

    assert checksum == 6_344_673_854_800
  end
end
