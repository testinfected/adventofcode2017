require 'lib/day8/registers'
require 'test/unit'

class RegistersTest < Test::Unit::TestCase

  def setup
    @regs = Hash.new(0)
  end

  def test_expression_parsing
    assert_equal({ :op => "inc", :reg => "b", :value => 5 }, parse_expression("b inc 5"))
    assert_equal({ :op => ">", :reg => "a", :value => 1 }, parse_expression("a > 1"))
  end

  def test_instruction_parsing
    assert_equal({ :op => "if", :condition => { :op => ">", :reg => "a", :value => 1}, :expression => { :op => "inc", :reg => "b", :value => 5 } },
                 parse_instruction("b inc 5 if a > 1"))
  end

  def test_statement_evaluation
    evaluate(parse_expression("b inc 5"), @regs)
    assert_equal(5, @regs["b"])
    evaluate(parse_expression("b dec 3"), @regs)
    assert_equal(2, @regs["b"])
  end

  def test_condition_evaluation
    assert_equal(false, evaluate(parse_expression("a > 1"), @regs))
    assert_equal(true, evaluate(parse_expression("a < 1"), @regs))
  end

  def test_instruction_evaluation
    program = <<-PROGRAM
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
    PROGRAM

    parse_program(program).each { |instruction|
      evaluate(instruction, @regs)
    }

    assert_equal(1, @regs["a"], "a")
    assert_equal(0, @regs["b"], "b")
    assert_equal(-10, @regs["c"], "c")
  end
end