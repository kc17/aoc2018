defmodule AoC.Day1 do
  def first do
    File.read!("#{System.cwd()}/priv/changes")
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(0, fn c, acc ->
      {str_action, str_delta} = String.split_at(c, 1)
      action = String.to_atom(str_action)
      delta = String.to_integer(str_delta)
      apply(Kernel, action, [acc, delta])
    end)
  end
end
