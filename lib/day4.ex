defmodule AdventOfCode.Day4 do
  def open_file() do
    data = File.read!("lib/inputs/day4.txt")
    String.trim(data)
  end

  def split_into_lines(input) do
    String.split(input, "\n")
  end

  def split_into_sets(input) do
    Enum.map(input, fn i ->
      pair = String.split(i, ",")
      [first, second] = pair
      {first_open, first_end} = String.split(first, "-") |> List.to_tuple()
      {second_open, second_end} = String.split(second, "-") |> List.to_tuple()
      first_set = create_sets(String.to_integer(first_open), String.to_integer(first_end))
      second_set = create_sets(String.to_integer(second_open), String.to_integer(second_end))
      [first_set, second_set]
    end)
  end

  def create_sets(start_range, end_range) do
    MapSet.new(for x <- start_range..end_range, do: x)
  end

  def calculate_results_part1(input) do
    Enum.reduce(input, 0, fn i, total ->
      first_set = List.first(i)
      second_set = List.last(i)

      cond do
        MapSet.subset?(first_set, second_set) -> total + 1
        MapSet.subset?(second_set, first_set) -> total + 1
        true -> total
      end
    end)
  end

  def calculate_results_part2(input) do
    Enum.reduce(input, 0, fn i, total ->
      first_set = List.first(i)
      second_set = List.last(i)

      cond do
        MapSet.disjoint?(first_set, second_set) -> total
        MapSet.disjoint?(second_set, first_set) -> total
        true -> total + 1
      end
    end)
  end

  def part1() do
    open_file()
    |> split_into_lines()
    |> split_into_sets()
    |> calculate_results_part1()
  end

  def part2() do
    open_file()
    |> split_into_lines()
    |> split_into_sets()
    |> calculate_results_part2()
  end
end
