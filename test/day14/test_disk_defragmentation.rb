require 'lib/day14/disk_defragmentation'
require 'test/unit'

class DiskDefragmentationTest < Test::Unit::TestCase

  def setup
    @disk = disk(<<-EOG
11.2.3..
.1.2.3.4
....5.6.
7.8.55.9
.88.5...
88..5...
.8......
88......
    EOG
    )
  end

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
    assert_equal(8108, Disk.decrypt("flqrgnkx").total_used)
  end

  def test_neighbors_of_square
    assert_equal(set([0, 1], [1, 2], [2, 1], [1, 0]), @disk.neighbors_of(1, 1).to_set)
    assert_equal(set([0, 1], [1, 0]), @disk.neighbors_of(0, 0).to_set)
  end

  def test_finding_regions
    assert_equal(set([0, 0], [0, 1], [1, 1]), @disk.region_containing([0, 0]))
    assert_equal(set([0, 0], [0, 1], [1, 1]), @disk.region_containing([1, 1]))
    assert_equal(set([0, 3], [1, 3]), @disk.region_containing([1, 3]))
  end

  def test_counting_regions
    assert_equal(9, @disk.total_regions)
    assert_equal(1242, Disk.decrypt("flqrgnkx").total_regions)
  end

  def disk(grid)
    Disk.new(grid.split("\n").map {|row| row.chars.map {|square| square == "." ? 0 : 1}})
  end

  def set(*squares)
    squares.to_set
  end
end