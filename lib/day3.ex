defmodule Day3 do
  @claims_path "#{System.cwd()}/priv/day3_claims"

  def part1(path \\ @claims_path) do
    overlaped_area =
      File.stream!(path)
      |> Stream.map(&establish_area/1)
      |> Enum.reduce({[], []}, &calc_overlap/2)
      |> elem(1)

    {Enum.count(overlaped_area), overlaped_area}
  end

  def part2(path \\ @claims_path) do
    {_, overlaped} = part1(path)

    File.stream!(path)
    |> Stream.map(&establish_area/1)
    |> Enum.reduce_while(nil, fn {id, area}, _ ->
      if :ordsets.intersection(area, overlaped) == [] do
        {:halt, id}
      else
        {:cont, nil}
      end
    end)
  end

  defp establish_area(claim) do
    regex = ~r/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/
    [_, id, x0, y0, w0, h0] = Regex.run(regex, claim)
    [x1, y1, w1, h1] = [x0, y0, w0, h0] |> Enum.map(&String.to_integer/1)

    area =
      for xd <- x1..(x1 + w1 - 1), yd <- y1..(y1 + h1 - 1) do
        {xd, yd}
      end

    {id, area}
  end

  defp calc_overlap({_, claim_area}, {used_area, overlaped}) do
    overlap = :ordsets.intersection(claim_area, used_area)
    {:ordsets.union(used_area, claim_area), :ordsets.union(overlap, overlaped)}
  end
end
