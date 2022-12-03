defmodule AdventOfCode.Day3 do
  @letters ~w[a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]

  def priorities do
    for x <- 0..(length(@letters) - 1), do: {x + 1, Enum.at(@letters, x)}
  end

  def open_file do
    data = File.read!("lib/inputs/day3.txt")
    String.trim(data)
  end

  def split_into_lines(input) do
    String.split(input, "\n")
  end

  def split_into_halves(input) do
    Enum.map(input, fn backpack ->
      half_size = div(String.length(backpack), 2)
      String.split_at(backpack, half_size)
    end)
  end

  def split_into_groups([], new_list), do: new_list

  def split_into_groups(input, new_list) do
    [first, second, three | tail] = input
    split_into_groups(tail, [{first, second, three} | new_list])
  end

  def find_duplicate_item_part1(input) do
    Enum.map(input, fn backpack ->
      first_half = elem(backpack, 0)
      second_half = elem(backpack, 1)

      Enum.reject(
        for x <- String.codepoints(first_half), y <- String.codepoints(second_half) do
          if x == y, do: x
        end,
        &is_nil/1
      )
      |> Enum.uniq()
    end)
  end

  def find_duplicate_item_part2(input) do
    Enum.map(input, fn backpack ->
      first_third = elem(backpack, 0)
      second_third = elem(backpack, 1)
      third_third = elem(backpack, 2)

      for x <- String.codepoints(first_third), y <- String.codepoints(second_third) do
        if x == y do
          for z <- String.codepoints(third_third) do
            if x == z, do: z
          end
        end
      end
      |> List.flatten()
      |> Enum.reject(&is_nil/1)
      |> Enum.uniq()
    end)
  end

  def calculate_score(data) do
    data = List.flatten(data)

    Enum.reduce(data, 0, fn value, total ->
      priority =
        Enum.find(priorities(), fn pair ->
          value == elem(pair, 1)
        end)

      elem(priority, 0) + total
    end)
  end

  def part1 do
    open_file()
    |> split_into_lines()
    |> split_into_halves()
    |> find_duplicate_item_part1()
    |> calculate_score()
  end

  def part2 do
    open_file()
    |> split_into_lines()
    |> split_into_groups([])
    |> find_duplicate_item_part2()
    |> calculate_score()
  end
end
