defmodule Day3Test do
  use ExUnit.Case

  setup do
    {:ok, path: "#{System.cwd()}/test/support/day3_test_claims"}
  end

  test "part1 returns the amount of overlap areas", ctx do
    %{path: path} = ctx

    assert Day3.part1(path) == {4, [{3, 3}, {3, 4}, {4, 3}, {4, 4}]}
  end

  test "part1 returns the only non overlap area's id", ctx do
    %{path: path} = ctx

    assert Day3.part2(path) == "3"
  end
end
