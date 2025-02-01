defmodule ThirtyDays.EnumStreamListTest do
  use ExUnit.Case

  @moduledoc """
  List module works explicitly on lists, e.g. [..]
  Enum module works on all kinds of Enumerables, including Lists, Maps, Tuples
  Stream module works like Enum, but is lazy. Can use Stream to generate collections
  at runtime, work with infinite streams etc. And feed it into Enum module functions
  """

  test "List.foldl vs Enum.reduce" do
    result = List.foldl([1, 2, 3, 4], 10, fn x, acc -> acc - x end)
    assert result == 0

    enum_result = Enum.reduce(1..4, 10, fn x, acc -> acc - x end)
    assert enum_result == result
  end

  test "Enum.reduce on maps and tuples" do
    result = Enum.reduce(%{a: 1, b: 2}, 0, fn {_key, val}, acc -> acc + val end)
    assert result == 3
  end

  test "generating streams with Stream.cycle" do
    cycle = Stream.cycle(1..3)
    nrs = Enum.take(cycle, 10)
    assert nrs == [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
  end

  test "generating infinite streams with Stream.repeatedly" do
    random_nr_stream = Stream.repeatedly(fn -> Enum.random(1..10) end)
    random_nrs = Enum.take(random_nr_stream, 10)
    nrs = Enum.filter(random_nrs, &(&1 >= 1 && &1 <= 10)) |> Enum.count()
    assert nrs == 10
  end

  test "generating infinite streams with Stream.unfold" do
    stream = Stream.unfold(0, fn x -> {x, x + 1} end)
    nrs = Enum.take(stream, 10)
    assert nrs == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end
