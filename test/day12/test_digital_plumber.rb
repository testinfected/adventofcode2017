require 'lib/day12/digital_plumber'
require 'test/unit'

class DigitalPlumberTest < Test::Unit::TestCase

  def setup
    @graph = graph_of(<<-EOG
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5
    EOG
    )
  end

  def test_parsing
    assert_equal(["0", %w(0)], edges_in("0 <-> 0"))
    assert_equal(["0", %w(0 3 4)], edges_in("0 <-> 0, 3, 4"))
  end

  def test_graph_walking
    assert_equal(%w(1), @graph.reachable_from("1"))
    assert_equal(%w(0 2 3 4 5 6), @graph.reachable_from("0"))
  end

  def test_grouping
    assert_equal([%w(0 2 3 4 5 6), %w(1)], @graph.groups)
  end
end