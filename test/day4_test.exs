defmodule Day4Test do
  use ExUnit.Case

  setup do
    {:ok, path: "#{System.cwd()}/test/support/day4_test_guards_log"}
  end

  test "part1 the id multiplies by the minute", ctx do
    %{path: path} = ctx
    assert Day4.part1(path) == 240
  end

  test "part2 the id multiplies by the minute", ctx do
    %{path: path} = ctx
    assert Day4.part2(path) == 4455
  end
end
