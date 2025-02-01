defmodule Sigils.SigilTest do
  @moduledoc """
  ~C char list without escaping or interpolation
  ~c char list with escaping and interpolation
  Analoguous for:
  regex: ~R and ~r
  string: ~S and ~s
  word list: ~W and ~w
  ~N NativeDateTime struct
  ~U DateTime struct

  List of delimiters:
  <>, {}, [], (), ||, //, "", ''
  """
  use ExUnit.Case
  import ThirtyDays.Sigil

  test "char list sigils" do
    assert '2 + 7 = 9' == ~c'2 + 7 = #{2 + 7}'
  end

  test "string sigils" do
    assert "This is my age: 28" == ~s"This is my age: #{14 + 14}"
  end

  test "regex sigils no match" do
    refute "Elixir" =~ ~r/elixir/
  end

  test "regex sigils match" do
    assert "elixir" =~ ~r/elixir/i
  end

  test "regex sigils match case insensitively" do
    assert "Elixir" =~ ~r/elixir/i
  end

  @doc """
  Avoid creating NaiveDateTime struct directly, use sigils instead
  """
  test "NaiveDateTime sigils" do
    assert NaiveDateTime.from_iso8601("2025-01-21 22:18:05") == {:ok, ~N[2025-01-21 22:18:05]}
  end

  @doc """
  DateTime uses UTC as timezone
  """
  test "DateTIme sigils" do
    assert DateTime.from_iso8601("2025-01-21 22:18:05Z") == {:ok, ~U[2025-01-21 22:18:05Z], 0}

    assert DateTime.from_iso8601("2025-01-21 20:18:05-0200") ==
             {:ok, ~U[2025-01-21 22:18:05Z], -7200}
  end

  test "Test custom string uppercase sigil p" do
    assert "HELLO" == ~p"hello"
  end

  test "Test custom string reverse sigil REV" do
    assert "olleh" == ~REV"hello"
  end
end
