defmodule AoC.Day1 do
  def first do
    read_changes
    |> Enum.reduce(0, &iterate_change/2)
  end

  def second(freq \\ 0, freq_list \\ []) do
    result =
      Enum.reduce_while(read_changes, {freq, freq_list}, fn c, {f0, fs} ->
        f1 = iterate_change(c, f0)
        if f1 in fs, do: {:halt, f1}, else: {:cont, {f1, [f1 | fs]}}
      end)

    if is_tuple(result) do
      second(elem(result, 0), elem(result, 1))
    else
      result
    end
  end

  defp read_changes do
    File.read!("#{System.cwd()}/priv/day1_changes")
    |> String.trim()
    |> String.split("\n")
  end

  defp iterate_change(change, freq) do
    {str_action, str_delta} = String.split_at(change, 1)
    apply(Kernel, String.to_atom(str_action), [freq, String.to_integer(str_delta)])
  end
end
