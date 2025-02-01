defmodule Aoc.DayOne.PartTwoTest do
  use ExUnit.Case
  import Aoc.DayOne.PartTwo

  test "Calculates occurrence of elements" do
    freqs = Enum.frequencies(create_list())

    assert freqs[1] == 2
    assert freqs[2] == 1
    assert freqs[3] == 3
    assert freqs[4] == nil
    assert freqs[8] == 1
  end

  test "Calculates similarity score for element" do
    freqs = Enum.frequencies(create_list())

    assert calculate_similarity_score_for_element(1, freqs) == 2
    assert calculate_similarity_score_for_element(2, freqs) == 2
    assert calculate_similarity_score_for_element(3, freqs) == 9
    assert calculate_similarity_score_for_element(6, freqs) == 6
    assert calculate_similarity_score_for_element(4, freqs) == 0
    assert calculate_similarity_score_for_element(8, freqs) == 8
  end

  test "Calculates similarity scores case1" do
    list_one = [1, 2, 3, 6, 4, 8]
    list_two = create_list()
    similarity_score = calculates_similarity_scores({list_one, list_two})

    assert similarity_score == 2 + 2 + 9 + 6 + 0 + 8
  end

  test "Calculates similarity scores case2" do
    list_one = [1, 2, 3, 6, 4, 8, 8]
    list_two = create_list()
    similarity_score = calculates_similarity_scores({list_one, list_two})

    assert similarity_score == 2 + 2 + 9 + 6 + 0 + 8 + 8
  end

  test "Completes PartTwo" do
    similarity_score = part_two()
    IO.puts(similarity_score)
    assert similarity_score == 24_941_624
  end

  defp create_list() do
    [1, 1, 2, 3, 3, 3, 6, 8]
  end
end
