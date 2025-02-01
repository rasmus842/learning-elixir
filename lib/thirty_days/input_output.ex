defmodule InputOutput do
  def interrogate do
    name = get_name()

    case String.downcase(get_cow_lover()) do
      "y" ->
        IO.puts("Great! Here's a cow for you #{name}:")
        IO.puts(cow_art())

      "n" ->
        IO.puts("That's a shame, #{name}")

      _ ->
        IO.puts("You should have entered 'y' or 'n'.")
    end
  end

  def get_name do
    IO.gets("What is your name? ")
    |> String.trim()
  end

  def get_cow_lover do
    IO.getn("Do you like cows? [y|n] ", 1)
  end

  def cow_art do
    path = Path.expand("priv/support/cow_art.txt")

    case File.read(path) do
      {:ok, art} -> art
      {:error, _} -> "Sorry, could not finx cow_art.txt"
    end
  end
end
