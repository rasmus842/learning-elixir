defmodule Learning do
  @moduledoc """
  Documentation for `Learning`.
  """

  @doc """
  Hello world.

  ## Examples
      iex> Learning.hello()
      :world

  """
  def hello do
    :world
  end

  defmacro is_correct(num1, num2) do
    quote do
      unquote(num1) > unquote(num2)
    end
  end

  def try_macro(num1, num2) when is_correct(num1, num2), do: "Correct!"
  def try_macro(_, _), do: "Incorrect!"
end
