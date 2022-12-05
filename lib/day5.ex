defmodule AdventOfCode.Day5 do
  def open_file() do
    data = File.read!("lib/inputs/day5.txt")
    String.trim(data)
  end

  def stacks do
    %{
      1 => ["L", "N", "W", "T", "D"],
      2 => ["C", "P", "H"],
      3 => ["W", "P", "H", "N", "D", "G", "M", "J"],
      4 => ["C", "W", "S", "N", "T", "Q", "L"],
      5 => ["P", "H", "C", "N"],
      6 => ["T", "H", "N", "D", "M", "W", "Q", "B"],
      7 => ["M", "B", "R", "J", "G", "S", "L"],
      8 => ["Z", "N", "W", "G", "V", "B", "R", "T"],
      9 => ["W", "G", "D", "N", "P", "L"]
    }
  end

  def split_into_lines(input) do
    String.split(input, "\n")
  end

  def extract_numbers(input) do
    Enum.flat_map(input, &String.split/1)
    |> Enum.reject(&(&1 == "move" or &1 == "from" or &1 == "to"))
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_tuple/1)
  end

  def do_manipulations_part1([], stacks), do: stacks

  def do_manipulations_part1(input, stacks) do
    [manip | tail] = input

    steps = elem(manip, 0)
    from = elem(manip, 1)
    to = elem(manip, 2)

    stacks = move_crates(steps, from, to, stacks)
    do_manipulations_part1(tail, stacks)
  end

  def move_crates(0, _, _, stacks), do: stacks

  def move_crates(repeat, from, to, stacks) do
    {crate, origin} = List.pop_at(stacks[from], -1)
    destination = stacks[to] ++ [crate]
    stacks = Map.put(stacks, from, origin)
    stacks = Map.put(stacks, to, destination)
    move_crates(repeat - 1, from, to, stacks)
  end

  def move_crates_ordered(quantity, from, to, stacks) do
    moving_crates = Enum.take(stacks[from], -quantity)
    {origin, _} = Enum.split(stacks[from], -quantity)
    destination = stacks[to] ++ moving_crates

    stacks
    |> Map.put(from, origin)
    |> Map.put(to, destination)
  end

  def do_manipulations_part2([], stacks), do: stacks

  def do_manipulations_part2(input, stacks) do
    [manip | tail] = input

    steps = elem(manip, 0)
    from = elem(manip, 1)
    to = elem(manip, 2)

    stacks = move_crates_ordered(steps, from, to, stacks)
    do_manipulations_part2(tail, stacks)
  end

  def pretty_print_answer(stacks) do
    for {key, val} <- stacks, into: %{}, do: {:"#{key}", Enum.take(val, -1)}
  end

  def part1 do
    open_file()
    |> split_into_lines()
    |> extract_numbers()
    |> do_manipulations_part1(stacks())
    |> pretty_print_answer()
  end

  def part2 do
    open_file()
    |> split_into_lines()
    |> extract_numbers()
    |> do_manipulations_part2(stacks())
    |> pretty_print_answer()
  end
end
