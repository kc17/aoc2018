defmodule Day5 do
  @polymer_path "#{System.cwd()}/priv/day5_polymer"

  def part1 do
    @polymer_path
    |> File.read!
    |> String.trim
    |> String.to_charlist
    |> run_reaction
    |> Enum.count
  end

  def run_reaction(charlist0) do
    charlist0
    |> Enum.reverse
    |> Enum.reduce([], &reduce_units/2)
  end

  defp reduce_units(char, [h | t]) when abs(char - h) == 32, do: t
  defp reduce_units(char, acc), do: [char | acc]
end
