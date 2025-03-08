defmodule Aoc.DayNine.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayNine.PartOne
  import Aoc.DayNine.PartTwo

  test "Gets file chunk size" do
    assert chunk_size({{0, 0}, 1}) == 1
    assert chunk_size({{0, 3}, -1}) == 4
    assert chunk_size({{3, 3}, 1}) == 1
    assert chunk_size({{3, 5}, 2}) == 3
  end

  test "Parses test map into chunks" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    fs_chunks = get_chunked_file_system(fs)

    assert fs_chunks == [
             {{0, 0}, 0},
             {{1, 2}, -1},
             {{3, 5}, 1},
             {{6, 9}, -1},
             {{10, 14}, 2}
           ]
  end

  test "Transforms chunks back into file_system" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    same_fs = get_chunked_file_system(fs) |> file_chunks_to_file_system()

    assert same_fs == fs
  end

  test "Finds next empty chunk" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    fs_chunks = get_chunked_file_system(fs)

    assert find_empty_chunk_by_size(fs_chunks, 1) == {{1, 2}, -1}
    assert find_empty_chunk_by_size(fs_chunks, 2) == {{1, 2}, -1}
    assert find_empty_chunk_by_size(fs_chunks, 3) == {{6, 9}, -1}
    assert find_empty_chunk_by_size(fs_chunks, 4) == {{6, 9}, -1}
    assert find_empty_chunk_by_size(fs_chunks, 5) == nil
  end

  test "Deletes file" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    new_fs =
      fs
      |> get_chunked_file_system()
      |> delete_file!({{3, 5}, 1})
      |> file_chunks_to_file_system()

    assert file_system_to_string(new_fs) == "0.........22222"
  end

  test "Copies file" do
    fs = parse("12345")
    assert file_system_to_string(fs) == "0..111....22222"

    new_fs =
      fs
      |> get_chunked_file_system()
      |> copy_file!({{6, 9}, -1}, {{3, 5}, 1})
      |> file_chunks_to_file_system()

    assert file_system_to_string(new_fs) == "0..111111.22222"
  end

  test "Corrects chunks" do
    disjointed_chunks =
      [
        {{0, 0}, 0},
        {{1, 2}, 1},
        {{3, 3}, -1},
        {{4, 5}, -1},
        {{5, 6}, 2},
        {{7, 9}, 2},
        {{10, 14}, 3}
      ]

    fs = disjointed_chunks |> file_chunks_to_file_system()
    assert file_system_to_string(fs) == "011...2222233333"

    corrected_chunks = correct_file_chunks(disjointed_chunks)

    assert corrected_chunks ==
             [
               {{0, 0}, 0},
               {{1, 2}, 1},
               {{3, 5}, -1},
               {{5, 9}, 2},
               {{10, 14}, 3}
             ]

    corrected_fs = file_chunks_to_file_system(corrected_chunks)

    assert corrected_fs == fs
  end

  test "Correctly reorganizes single file in file system" do
    fs = parse("13321")
    assert file_system_to_string(fs) == "0...111..2"

    reorganized_fs =
      fs
      |> get_chunked_file_system()
      |> reorganize({{4, 6}, 1})
      |> file_chunks_to_file_system()

    assert file_system_to_string(reorganized_fs) == "0111.....2"
  end

  test "Correctly reorganizes two files in file system" do
    fs = parse("14321")
    assert file_system_to_string(fs) == "0....111..2"

    reorganized_fs =
      fs
      |> get_chunked_file_system()
      |> reorganize({{10, 10}, 2})
      |> reorganize({{5, 7}, 1})
      |> file_chunks_to_file_system()

    assert file_system_to_string(reorganized_fs) == "02111......"
  end

  test "Correctly reorganizes all files in file system" do
    fs = parse("13321")
    assert file_system_to_string(fs) == "0...111..2"

    reorganized_fs = reorganize_file_system(fs)

    assert file_system_to_string(reorganized_fs) == "02..111..."
  end

  test "Correctly reorganizes all files in test file system" do
    fs = parse("2333133121414131402")
    assert file_system_to_string(fs) == "00...111...2...333.44.5555.6666.777.888899"

    reorganized_fs = reorganize_file_system(fs)

    assert file_system_to_string(reorganized_fs) == "00992111777.44.333....5555.6666.....8888.."
  end

  test "Completes Part Two" do
    checksum =
      Path.join(["priv", "aoc", "day_nine.txt"])
      |> File.read!()
      |> parse()
      |> reorganize_file_system()
      |> calculate_checksum()

    assert checksum == 6_360_363_199_987
  end
end
