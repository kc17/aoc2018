defmodule Day5 do
  @polymer_path "#{System.cwd()}/priv/day5_polymer"

  def part1 do
    @polymer_path
    |> polymer_charlist
    |> run_reaction
    |> Enum.count()
  end

  def part2 do
    polymer =
      @polymer_path
      |> polymer_charlist

    polymer
    |> Enum.map(fn
      u when u >= ?a -> u - 32
      u -> u
    end)
    |> Enum.uniq()
    |> Enum.map(fn u ->
      polymer
      |> Enum.reject(&(&1 in [u, u + 32]))
      |> run_reaction
      |> Enum.count()
    end)
    |> Enum.min()
  end

  def run_reaction(charlist0) do
    charlist0
    |> Enum.reverse()
    |> Enum.reduce([], &reduce_units/2)
  end

  def polymer_charlist(path) do
    path
    |> File.read!()
    |> String.trim()
    |> String.to_charlist()
  end

  defp reduce_units(char, [h | t]) when abs(char - h) == 32, do: t
  defp reduce_units(char, acc), do: [char | acc]
end
