defmodule Aoc.DayOne.PartTwo do
  alias Aoc.DayOne.PartOne, as: PartOne

  def part_two do
    File.stream!("priv/aoc/aoc1.txt")
    |> PartOne.read_stream_into_tuple()
    |> calculates_similarity_scores()
  end

  def calculates_similarity_scores({list_one, list_two}) do
    frequencies = Enum.frequencies(list_two)

    list_one
    |> Enum.reduce(0, &(calculate_similarity_score_for_element(&1, frequencies) + &2))
  end

  def calculate_similarity_score_for_element(element, frequencies) do
    case frequencies[element] do
      nil -> 0
      frequency -> element * frequency
    end
  end

  def calculate_occurence_of_element(element, frequencies) do
    frequencies[element]
  end
end
