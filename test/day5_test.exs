defmodule Day5Test do
  use ExUnit.Case

  @test_data 'dabAcCaCBAcCcaDA'

  test "run_reaction returns the fully reacted string" do
    assert Day5.run_reaction(@test_data) == 'dabCBAcaDA'
    assert Day5.run_reaction('aA') == ''
    assert Day5.run_reaction('abBA') == ''
    assert Day5.run_reaction('abAB') == 'abAB'
    assert Day5.run_reaction('aabAAB') == 'aabAAB'
  end
end
