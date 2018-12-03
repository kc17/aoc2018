defmodule AoC.Day2 do
  def part1 do
    File.stream!("#{System.cwd()}/priv/day2_box_ids")
    |> Stream.flat_map(&process_id/1)
    |> group_and_count
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp process_id(id) do
    id
    |> String.trim
    |> String.graphemes()
    |> group_and_count
    |> Enum.reject(&(&1 <= 1))
    |> Enum.group_by(& &1)
    |> Enum.reduce([], fn({k, _}, acc) -> [k | acc] end)
  end

  defp group_and_count(list) do
    list
    |> Enum.group_by(& &1)
    |> Map.values
    |> Enum.map(&Enum.count/1)
  end
end
