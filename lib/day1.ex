defmodule AdventOfCode.Day1 do
  def open_file do
    File.read!("lib/inputs/day1.txt")
  end

  def split_input(input) do
    String.split(input, "\n\n")
    |> Enum.map(fn string -> String.split(string, "\n") end)
  end

  def add_values(arr) do
    Enum.reduce(arr, [], fn value, acc ->
      int_arr =
        Enum.map(value, fn
          "" ->
            0

          v ->
            String.to_integer(v)
        end)

      total = Enum.reduce(int_arr, fn x, acc -> x + acc end)
      List.insert_at(acc, 0, total)
    end)
  end

  def launch do
    open_file()
    |> split_input()
    |> add_values()
    |> Enum.sort(:desc)
  end
end
