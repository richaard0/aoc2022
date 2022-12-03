defmodule AdventOfCode.Day2 do
  def open_file do
    File.read!("lib/inputs/day2.txt")
  end

  def split_into_rounds(input) do
    String.trim(input)
    |> String.split("\n")
    |> Enum.map(fn r -> String.split(r, " ") |> List.to_tuple() end)
  end

  def calculate_score(rounds) do
    Enum.reduce(rounds, 0, fn match, score -> score + check_match_score(match) end)
  end

  def check_match_score(match) do
    my_move = elem(match, 1)

    case match_result(match) do
      :won ->
        6 + my_score(my_move)

      :lost ->
        0 + my_score(my_move)

      :draw ->
        3 + my_score(my_move)
    end
  end

  def my_score(letter) do
    case letter do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  def match_result(match) do
    case match do
      {"A", "Y"} -> :won
      {"B", "Z"} -> :won
      {"C", "X"} -> :won
      {"A", "Z"} -> :lost
      {"B", "X"} -> :lost
      {"C", "Y"} -> :lost
      _ -> :draw
    end
  end

  def determine_outcome(letter) do
    case letter do
      "X" -> :lose
      "Y" -> :draw
      "Z" -> :win
    end
  end

  def determine_my_move(match, :win) do
    their_move = elem(match, 0)

    case their_move do
      "A" -> "Y"
      "B" -> "Z"
      "C" -> "X"
    end
  end

  def determine_my_move(match, :lose) do
    their_move = elem(match, 0)

    case their_move do
      "A" -> "Z"
      "B" -> "X"
      "C" -> "Y"
    end
  end

  def determine_my_move(match, :draw) do
    their_move = elem(match, 0)

    case their_move do
      "A" -> "X"
      "B" -> "Y"
      "C" -> "Z"
    end
  end

  def calculate_score_p2(rounds) do
    Enum.reduce(rounds, 0, fn match, score ->
      outcome = determine_outcome(elem(match, 1))
      my_move = determine_my_move(match, outcome)

      case outcome do
        :win -> 6 + my_score(my_move) + score
        :draw -> 3 + my_score(my_move) + score
        :lose -> 0 + my_score(my_move) + score
      end
    end)
  end

  def launch_part_1 do
    open_file()
    |> split_into_rounds()
    |> calculate_score()
    |> IO.inspect()
  end

  def launch_part_2 do
    open_file()
    |> split_into_rounds()
    |> calculate_score_p2()
    |> IO.inspect()
  end
end
