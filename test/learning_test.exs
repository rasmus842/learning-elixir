defmodule LearningTest do
  use ExUnit.Case
  import Learning

  test "greets the world" do
    assert hello() == :world
  end

  test "Testing macro" do
    assert try_macro(5, 1) == "Correct!"
    assert try_macro(1, 5) == "Incorrect!"

    assert is_correct(5, 1) == true
    assert is_correct(1, 5) == false
  end
end
