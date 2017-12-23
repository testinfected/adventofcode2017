defmodule HighEntropyPassphrases.Test do
  use ExUnit.Case

  import HighEntropyPassphrases

  test "rejects empty passphrase" do
    assert is_valid("") == false
  end

  test "rejects duplicate words in passphrases" do
    assert is_valid("aa bb cc dd ee")
    assert is_valid("aa bb cc dd aa") == false
    assert is_valid("aa bb cc dd aaa")
  end

  test "rejects passphrases with words anagrams" do
    assert is_valid("abcde fghij")
    assert is_valid("abcde xyz ecdab") == false
    assert is_valid("a ab abc abd abf abj")
    assert is_valid("iiii oiii ooii oooi oooo")
    assert is_valid("oiii ioii iioi iiio") == false
  end
end