defmodule AdventOfCode.Day6 do
  def open_file() do
    data = File.read!("lib/inputs/day6.txt")
    String.trim(data)
  end

  def scan_input(input, length) do
    marker =
      String.split(input, "", trim: true)
      |> Enum.chunk_every(length, 1)
      |> Enum.reject(fn array ->
        Enum.uniq(array) != array
      end)
      |> List.first()
      |> Enum.reduce("", fn char, acc -> acc <> char end)

    {marker, input}
  end

  def count_chars({marker, input}) do
    [first_part, _] = String.split(input, marker)
    String.length(first_part) + String.length(marker)
  end

  def part1 do
    open_file()
    |> scan_input(4)
    |> count_chars()
  end

  def part2 do
    open_file()
    |> scan_input(14)
    |> count_chars()
  end
end
