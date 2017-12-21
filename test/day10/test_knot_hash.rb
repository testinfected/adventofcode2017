require 'lib/day10/knot_hash'
require 'test/unit'

class KnotHashTest < Test::Unit::TestCase

  def test_knot_tiying
    assert_equal([2, 1, 0, 3, 4], tie([0, 1, 2, 3, 4], 0, 3))
    assert_equal([4, 3, 0, 1, 2], tie([2, 1, 0, 3, 4], 3, 4))
    assert_equal([4, 3, 0, 1, 2], tie([4, 3, 0, 1, 2], 8, 1))
    assert_equal([3, 4, 2, 1, 0], tie([4, 3, 0, 1, 2], 11, 5))

    knots = tie_knots([3, 4, 1, 5], Knots.new([0, 1, 2, 3, 4], 0, 0))
    assert_equal([3, 4, 2, 1, 0], knots.marks)
  end

  def test_knot_hash
    assert_equal(12, knot_hash([3, 4, 1, 5], marks = [0, 1, 2, 3, 4]))
  end

  def test_converting_bytes_to_ascii
    assert_equal([49, 44, 50, 44, 51], to_ascii("1,2,3"))
  end

  def test_xor_of_block
    assert_equal(64, xor([65, 27, 9, 1, 4, 3, 40, 50, 91, 7, 6, 0, 2, 5, 68, 22]))
  end

  def test_hex_representation
    assert_equal("4007ff", to_hex([64, 7, 255]))
  end

  def test_examples_of_dense_hashes
    assert_equal("a2582a3a0e66e6e86e3812dcb672a272", dense_hash_of(""))
    assert_equal("33efeb34ea91902bb2f59c9920caa6cd", dense_hash_of("AoC 2017"))
    assert_equal("3efbe78a8d82f29979031a4aa0b16a9d", dense_hash_of("1,2,3"))
    assert_equal("63960835bcdc130f0b66d7ff4f6a5a8e", dense_hash_of("1,2,4"))
  end
end
