require 'lib/day14/disk_defragmentation'
require 'test/unit'

class DiskDefragmentationTest < Test::Unit::TestCase

  def test_hexa_to_bits
    assert_equal("1010", to_bits("a"))
    assert_equal("0000", to_bits("0"))
    assert_equal("1010000011000010000000010111", to_bits("a0c2017"))
  end

  def test_knot_hash_decoding
      assert_equal([1, 1, 0, 1, 0, 1, 0, 0], decode("flqrgnkx-0")[0...8])
      assert_equal([0, 1, 0, 1, 0, 1, 0, 1], decode("flqrgnkx-1")[0...8])
  end

  def test_counting_used_squares
      assert_equal(8108, used(disk("flqrgnkx")))
  end
end