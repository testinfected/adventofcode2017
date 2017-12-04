defmodule Adventofcode2017.InverseCaptcha do
  defp parse(input) do
    String.codepoints(input)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn { value, _ } -> value end)
  end

  defp captcha(input, offset) when is_binary(input) do
    captcha(parse(input), offset)
  end

  defp captcha(input, offset) do
    0..length(input)
    |> Enum.filter(fn i -> Enum.at(input, i) == Enum.at(input, rem(i + offset, length(input))) end)
    |> Enum.reduce(0, fn i, acc -> Enum.at(input, i) + acc end)
  end

  def captcha1(input), do: captcha(input, 1)

  def captcha2(input), do: captcha(input, div(String.length(input), 2))

end

