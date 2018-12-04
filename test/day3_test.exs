defmodule Day3Test do
  use ExUnit.Case

  setup do
    {:ok, path: "#{System.cwd()}/test/support/day3_test_claims"}
  end

  test "part1 returns the amount of overlap areas", ctx do
    %{path: path} = ctx

    assert Day3.part1(path) == 4
  end
end
