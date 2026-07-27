defmodule ThirtyDays.ProcessRingTest do
  use ExUnit.Case

  test "Test how a process ring works" do
    ThirtyDays.ProcessRing.Spawner.start(5)
  end
end
