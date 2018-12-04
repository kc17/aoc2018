defmodule Day4 do
  @guards_log "#{System.cwd()}/priv/day4_guards_log"

  def part1(path \\ @guards_log) do
    File.stream!(path)
    |> build_guard_log
    |> Enum.max_by(fn {_, mins} -> Enum.count(mins) end)
    |> calc_value
  end

  def part2(path \\ @guards_log) do
    File.stream!(path)
    |> build_guard_log
    |> Enum.max_by(fn {_, mins} ->
      calc_mins_occ_max(mins) |> elem(1)
    end)
    |> calc_value
  end

  def cast("[" <> <<dt_str::bytes-size(16)>> <> "] " <> log) do
    %{
      timestamp: NaiveDateTime.from_iso8601!(dt_str <> ":00"),
      log: String.trim(log)
    }
  end

  defp build_guard_log(log_stream) do
    log_stream
    |> Stream.map(&cast/1)
    |> Enum.sort_by(& &1.timestamp, &(NaiveDateTime.compare(&1, &2) in [:lt, :eq]))
    |> Enum.reduce({nil, nil, []}, &build_segment/2)
    |> elem(2)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 2))
    |> Enum.map(fn {gid, segs} -> {gid, Enum.concat(segs)} end)
  end

  defp build_segment(record, {gid, sleep_min, segments}) do
    case record.log do
      "Guard #" <> guard_str ->
        guard_id = guard_str |> String.split() |> List.first() |> String.to_integer()
        {guard_id, nil, segments}

      "falls asleep" ->
        {gid, Map.get(record.timestamp, :minute), segments}

      "wakes up" ->
        date = NaiveDateTime.to_date(record.timestamp)
        wake_min = Map.get(record.timestamp, :minute)
        {gid, nil, segments ++ [{gid, date, sleep_min..(wake_min - 1)}]}
    end
  end

  defp calc_value({gid, mins}) do
    calc_mins_occ_max(mins)
    |> elem(0)
    |> Kernel.*(gid)
  end

  defp calc_mins_occ_max(mins) do
    {min, mins} =
      Enum.group_by(mins, & &1)
      |> Enum.max_by(fn {_, occ} -> Enum.count(occ) end)

    {min, Enum.count(mins)}
  end
end
