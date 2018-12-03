defmodule AoC.Day2 do
  @fs File.stream!("#{System.cwd()}/priv/day2_box_ids")

  def part1 do
    @fs
    |> Stream.flat_map(&process_id/1)
    |> group_and_count
    |> Enum.reduce(1, &(&1 * &2))
  end

  def part2 do
    @fs
    |> Enum.reduce_while([], fn id, list ->
      case String.trim(id) |> compare(list) do
        {:found, commons} -> {:halt, commons}
        _ -> {:cont, [id | list]}
      end
    end)
  end

  defp process_id(id) do
    id
    |> String.trim()
    |> String.graphemes()
    |> group_and_count
    |> Enum.reject(&(&1 <= 1))
    |> Enum.group_by(& &1)
    |> Enum.reduce([], fn {k, _}, acc -> [k | acc] end)
  end

  defp group_and_count(list) do
    list
    |> Enum.group_by(& &1)
    |> Map.values()
    |> Enum.map(&Enum.count/1)
  end

  defp compare(_, []), do: :not_found

  defp compare(current, [h | t]) do
    diff = String.myers_difference(current, h)

    diff_count =
      Keyword.get_values(diff, :del)
      |> Enum.join()
      |> String.length()

    if diff_count > 1 do
      compare(current, t)
    else
      commons =
        Keyword.get_values(diff, :eq)
        |> Enum.join()

      {:found, commons}
    end
  end
end
