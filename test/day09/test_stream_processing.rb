require 'lib/day09/stream_processing'
require 'test/unit'

class StreamProcessingTest < Test::Unit::TestCase
  def test_scoring
      assert_equal(0, total_score(""), "")
      assert_equal(1, total_score("{}"), "{}")
      assert_equal(3, total_score("{{}}"), "{{}}")
      assert_equal(5, total_score("{{},{}}"), "{{},{}}")
      assert_equal(16, total_score("{{{},{},{{}}}}"), "{{{},{},{{}}}}")
  end
  #
  def test_ignoring_garbage
      assert_equal(0, total_score("<>"), "<>")
      assert_equal(0, total_score("<random chars>"), "<random chars>")
      assert_equal(0, total_score("<{}>"), "<{}>")
      assert_equal(1, total_score("{<a>,<a>,<a>,<a>}"), "{<a>,<a>,<a>,<a>}")
      assert_equal(1, total_score("{<<<<>}"), "{<<<<>}")
      assert_equal(3, total_score("{<<<<>, {}"), "{<<<<>, {}")
      assert_equal(1, total_score("{<{},{},{{}}>}"), "{<{},{},{{}}>}")
      assert_equal(9, total_score("{{<ab>},{<ab>},{<ab>},{<ab>}}"), "{{<ab>},{<ab>},{<ab>},{<ab>}}")
  end

  def test_cleaning_up_garbage
      assert_equal(0, total_score("<!>{}>"), "<{!>{}>")
      assert_equal(1, total_score("<!!!>{}>{}"), "<!!!>{}>{}")
      assert_equal(9, total_score("{{<!!>},{<!!>},{<!!>},{<!!>}}"), "{{<!!>},{<!!>},{<!!>},{<!!>}}")
      assert_equal(3, total_score("{{<a!>},{<a!>},{<a!>},{<ab>}}"), "{{<a!>},{<a!>},{<a!>},{<ab>}}")
  end

  def test_counting_garbage
      assert_equal(0, count_garbage("<>"), "<>")
      assert_equal(17, count_garbage("<random characters>"), "<random characters>")
      assert_equal(3, count_garbage("<<<<>"), "<<<<>")
      assert_equal(2, count_garbage("<{!>}>"), "<{!>}>")
      assert_equal(0, count_garbage("<!!!>>"), "<!!!>>")
      assert_equal(10, count_garbage("<{o'i!a,<{i<a>"), "<{o'i!a,<{i<a>")
      assert_equal(0, count_garbage("abcdef<>012345"), "abcdef<>012345")
  end
end
