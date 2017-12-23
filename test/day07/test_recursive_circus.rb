require 'lib/day07/recursive_circus'
require 'test/unit'

class RecursiveCircusTest < Test::Unit::TestCase

  def setup
    @towers = parse_entire_tower(<<TOWERS
pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
TOWERS
    )
  end

  def test_parsing_leaf_tower
    assert_equal(["abc", Tower.new("abc", 10, [])], parse_sub_tower("abc (10)"))
  end

  def test_parsing_branch_tower
    assert_equal(["abc", Tower.new("abc", 10, %w(def ghi jkl))], parse_sub_tower("abc (10) -> def, ghi, jkl"))
  end

  def test_finding_base_tower
    assert_equal("tknk", base_tower(@towers))
  end

  def test_computing_stack_weights
    assert_equal(61, weights(@towers)["ebii"])
    assert_equal(251, weights(@towers)["ugml"])
    assert_equal(243, weights(@towers)["padx"])
    assert_equal(243, weights(@towers)["fwft"])
    assert_equal(778, weights(@towers)["tknk"])
  end

  def test_finding_unbalanced_stack()
    assert_equal([], @towers["padx"].find_unbalanced(@towers))
    assert_equal([], @towers["ugml"].find_unbalanced(@towers))
    assert_equal([:name => "ugml", :weight_offset => -8], @towers["tknk"].find_unbalanced(@towers))
  end

  def test_balancing_tower()
    assert_equal(["ugml", 60], balance_tower(@towers))
  end
end