defmodule ThirtyDays.ListTest do
  use ExUnit.Case

  def sample() do
    ["Tim", "jen", "Max", "Kai"]
  end

  test "word list sigil" do
    assert sample() == ~w(Tim jen Max Kai)
  end

  test "head" do
    [head | _] = sample()
    assert head == "Tim"
    # can also match the whole part
    assert ["Tim" | ["jen", "Max", "Kai"]] == sample()
  end

  test "tail" do
    [_ | tail] = sample()
    assert tail == ~w(jen Max Kai)
  end

  test "last item" do
    # Warning! has to traverse the entire list!
    assert List.last(sample()) == "Kai"
  end

  test "delete item" do
    assert List.delete(sample(), "Max") == ~w(Tim jen Kai)
    # only deletes first occurrence
    assert List.delete([1, 2, 2, 3], 2) == [1, 2, 3]
  end

  test "List.fold" do
    list = [20, 10, 5, 2.5]
    sum = List.foldr(list, 0, &(&1 + &2))
    # or: List.foldr(list, 0, fn (num, sum) -> num + sum end)
    assert sum == 37.5
  end

  # foldl is usually more performant and memory efficient
  # because of tail end recursion
  # foldr has to evaluate the whole expression and in memory
  test "foldr vs foldl" do
    list = [1, 2, 3, 4]
    # foldr starts from end, therefore: (1 - (2 - (3 - (4 - 0)))) = -2
    sub_foldr = List.foldr(list, 0, &(&1 - &2))
    assert sub_foldr == -2
    # foldl starts from end, therefore: (4 - (3 - (2 - (1 - 0)))) = 2
    sub_foldl = List.foldl(list, 0, &(&1 - &2))
    assert sub_foldl == 2
  end

  # Enum methods are encouraged over List methods
  test "Enum.reduce" do
    list = [20, 10, 5, 2.5]
    sum = Enum.reduce(list, 0, &(&1 + &2))
    # or: List.foldr(list, 0, fn (num, sum) -> num + sum end)
    assert sum == 37.5
  end

  test "wrap" do
    # List.wrap/1, returns argument as a list, if it was not one already
    # nil returns []
    assert List.wrap(sample()) == sample()
    assert List.wrap(1) == [1]
    assert List.wrap([]) == []
    assert List.wrap(nil) == []
  end

  test "list comprehension" do
    some = for n <- sample(), String.first(n) == "K", do: n <> " Morgan"
    assert some == ["Kai Morgan"]
  end

  test "Enum.reverse speed" do
    {microsec, reversed} =
      :timer.tc(fn ->
        Enum.reverse(1..1_000_000)
      end)

    assert reversed == Enum.to_list(1_000_000..1)
    IO.puts("Enum.reverse took #{microsec} microsecs")
  end

  test "Manual reverse speed" do
    {microsec, reversed} =
      :timer.tc(fn ->
        Enum.reduce(1..1_000_000, [], fn i, list -> List.insert_at(list, 0, i) end)
      end)

    assert reversed == Enum.to_list(1_000_000..1)
    IO.puts("Enum.reverse took #{microsec} microsecs")
  end
end
