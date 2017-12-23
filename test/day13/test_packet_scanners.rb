require 'lib/day13/packet_scanners'
require 'test/unit'

class PacketScannersTest < Test::Unit::TestCase

  def setup
    @firewall = firewall(<<-EOF
0: 3
1: 2
4: 4
6: 4
    EOF
    )
  end

  def test_scanner_definition
    assert_equal([0, 3], scanner("0: 3"))
    assert_equal([1, 4], scanner("1: 4"))
    assert_equal([14, 24], scanner("14: 24"))

    assert_equal({0 => 3, 1 => 2, 4 => 4, 6 => 4}, @firewall)
  end

  def test_scanner_over_time
    assert_equal(0, scanner_position(height = 3, time = 0))
    assert_equal(1, scanner_position(height = 3, time = 1))
    assert_equal(2, scanner_position(height = 3, time = 2))
    assert_equal(1, scanner_position(height = 3, time = 3))
    assert_equal(0, scanner_position(height = 3, time = 4))
    assert_equal(1, scanner_position(height = 3, time = 5))
  end

  def test_packet_ride_hits
    assert_equal({0 => 3, 6 => 4}, ride_packet(@firewall))
    assert_equal({}, ride_packet(@firewall, 10))
  end

  def test_severity_of_trip
    assert_equal(24, trip_severity(@firewall))
  end

  def test_planning_safe_trip
    assert_equal(10, delay(@firewall))
  end
end