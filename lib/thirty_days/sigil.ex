defmodule ThirtyDays.Sigil do
  @moduledoc """
  Creating sigils:

  As an example, lets create a sigil that converts
  a string to uppercase, essentially what String.upcase/1 does
  """

  @doc """
  This creates sigil p and it works as expected
  ~p"hello" -> "HELLO"
  """
  def sigil_p(string, []), do: String.upcase(string)

  @doc """
  For multicharacted sigils, all characters must be uppercase
  example: ~REV"hello" -> "olleh"
  """
  def sigil_REV(string, []), do: String.reverse(string)
end
