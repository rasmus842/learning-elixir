defmodule Aoc.DayNine.PartTwo do
  def reorganize_file_system(file_system) do
    fs_chunks = get_chunked_file_system(file_system)

    fs_chunks
    |> Enum.reverse()
    |> Enum.reject(fn {_pos, f_id} -> f_id == -1 end)
    |> Enum.reduce(fs_chunks, fn curr_file_chunk, curr_fs_chunks ->
      reorganize(curr_fs_chunks, curr_file_chunk)
    end)
    |> file_chunks_to_file_system()
  end

  def reorganize(file_system_chunks, file_chunk) do
    file_chunk_size = chunk_size(file_chunk)
    empty_chunk = find_empty_chunk_by_size(file_system_chunks, file_chunk_size)

    file_system_chunks
    |> reorganize(empty_chunk, file_chunk)
    |> correct_file_chunks()
  end

  def reorganize(file_system, nil, _file_chunk), do: file_system

  def reorganize(file_system, {{l, _r}, -1}, {{l2, _r2}, _f_id}) when l2 < l, do: file_system

  def reorganize(file_system, empty_chunk, file_chunk) do
    file_system
    |> copy_file!(empty_chunk, file_chunk)
    |> delete_file!(file_chunk)
  end

  def copy_file!([], empty_chunk, _chunk) do
    IO.inspect(empty_chunk)
    raise("Empty chunk not found!")
  end

  def copy_file!(
        _file_system = [curr_chunk | rest],
        empty_chunk,
        chunk
      )
      when curr_chunk != empty_chunk do
    [curr_chunk | copy_file!(rest, empty_chunk, chunk)]
  end

  def copy_file!(
        _file_system = [_curr_chunk | rest],
        empty_chunk = {available_pos = {left, right}, -1},
        file_chunk = {_file_pos, f_id}
      ) do
    case chunk_size(empty_chunk) - chunk_size(file_chunk) do
      0 ->
        [{available_pos, f_id} | rest]

      leftover_space when leftover_space > 0 ->
        [
          {{left, right - leftover_space}, f_id},
          {{right - (leftover_space - 1), right}, -1} | rest
        ]

      leftover_space when leftover_space < 0 ->
        raise("Not enough file space!")
    end
  end

  def delete_file!([], file_chunk) do
    IO.inspect(file_chunk)
    raise("Could not find file to delete!")
  end

  def delete_file!([curr_chunk | rest], file_chunk) when curr_chunk != file_chunk do
    [curr_chunk | delete_file!(rest, file_chunk)]
  end

  def delete_file!([_ | rest], _file_chunk = {pos, _f_id1}), do: [{pos, -1} | rest]

  def find_empty_chunk_by_size(chunks, size) do
    chunks
    |> Stream.filter(fn {_pos, f_id} -> f_id == -1 end)
    |> Enum.find(&(chunk_size(&1) >= size))
  end

  def get_chunked_file_system(file_system) do
    file_system
    |> Enum.with_index()
    |> Enum.chunk_by(fn {f_id, _i} -> f_id end)
    |> Enum.map(fn chunk ->
      chunk
      |> Enum.reduce({{nil, nil}, nil}, fn
        {f_id, i}, {{nil, nil}, nil} -> {{i, i}, f_id}
        {_, i}, {{first_pos, _last_pos}, fid} -> {{first_pos, i}, fid}
      end)
    end)
  end

  def file_chunks_to_file_system(chunks) do
    chunks
    |> Enum.flat_map(fn chunk = {_pos, f_id} ->
      0..(chunk_size(chunk) - 1)
      |> Enum.map(fn _i -> f_id end)
    end)
  end

  def correct_file_chunks([]), do: []
  def correct_file_chunks([a]), do: [a]

  def correct_file_chunks([
        first = {_pos, f_id},
        second = {_pos2, f_id2}
        | rest
      ])
      when f_id != f_id2 do
    [first | correct_file_chunks([second | rest])]
  end

  def correct_file_chunks([
        _first = {{left, _right}, f_id},
        _second = {{_left2, right2}, f_id2}
        | rest
      ])
      when f_id == f_id2 do
    corrected_file_chunk = {{left, right2}, f_id}
    correct_file_chunks([corrected_file_chunk | rest])
  end

  def chunk_size({{start, last}, _f_id}), do: last - start + 1
end
