defmodule InverseCaptcha.Test do
  use ExUnit.Case

  import InverseCaptcha

  test "part 1" do
    assert captcha1("1234") == 0
    assert captcha1("1122") == 3
    assert captcha1("1111") == 4
    assert captcha1("91212129") == 9
  end

  test "part 2" do
    assert captcha2("1212") == 6
    assert captcha2("1221") == 0
    assert captcha2("123425") == 4
    assert captcha2("123123") == 12
    assert captcha2("12131415") == 4
  end
end