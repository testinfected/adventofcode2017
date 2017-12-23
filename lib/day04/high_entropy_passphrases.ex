defmodule HighEntropyPassphrases do

  def count_valid(passphrase_list) do
    passphrase_list |> String.split("\n") |> Enum.filter(&is_valid/1) |> Enum.count
  end

  def is_valid(""), do: false

  def is_valid(passphrase) when is_binary(passphrase) do
    is_valid(String.split(passphrase))
  end

  def is_valid(words) do
    !contains_duplicates([], words |> Enum.map(&to_letters/1))
  end

  defp contains_duplicates(_, []), do: false

  defp contains_duplicates(a, b) do
    [head | tail] = b
    head in a or contains_duplicates(a ++ [head], tail)
  end

  defp to_letters(passphrase), do: to_charlist(passphrase) |> Enum.sort
end
