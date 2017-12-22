require 'lib/day11/hex_ed'
require 'test/unit'

class HexEdTest < Test::Unit::TestCase

  def test_moving_along_the_hex_grid
    moves = move([:ne, :s, :sw, :nw, :n, :se])

    assert_equal([1, 0, -1], moves.next.coords)
    assert_equal([1, -1, 0], moves.next.coords)
    assert_equal([0, -1, 1], moves.next.coords)
    assert_equal([-1, 0, 1], moves.next.coords)
    assert_equal([-1, 1, 0], moves.next.coords)
    assert_equal([0, 0, 0], moves.next.coords)
  end

  def test_distance_to_origin
    assert_equal(5, Cube.new(5, -3, -2).distance)
    assert_equal(4, Cube.new(-4, 3, 1).distance)
  end
end