def parse_expression(statement)
  /^(?<reg>.*?)\s(?<op>.*?)\s(?<value>.*?)$/ =~ statement
  {:op => op, :reg => reg, :value => value.to_i}
end

def parse_instruction(statement)
  /^(?<expression>.*?)\sif\s(?<condition>.*?)$/ =~ statement
    {:op => "if", :condition => parse_expression(condition), :expression => parse_expression(expression)}
end

def parse_program(program)
  program.split(/\n/).map { |line| parse_instruction(line) }
end

def evaluate(expression, registers)
  case expression[:op]
    when "if"
      evaluate(expression[:expression], registers) if evaluate(expression[:condition], registers)
    when "inc"
      registers[expression[:reg]] += expression[:value]
    when "dec"
      registers[expression[:reg]] -= expression[:value]
    when ">"
      registers[expression[:reg]] > expression[:value]
    when "<"
      registers[expression[:reg]] < expression[:value]
    when ">="
      registers[expression[:reg]] >= expression[:value]
    when "<="
      registers[expression[:reg]] <= expression[:value]
    when "=="
      registers[expression[:reg]] == expression[:value]
    when "!="
      registers[expression[:reg]] != expression[:value]
  end
end

def evaluate_program(program, registers = Hash.new(0))
  parse_program(program).each { |instruction|
    evaluate(instruction, registers)
  }
  registers
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))

memory = Hash.new(0)
def memory.[]=(key, value)
  super
  @highest = value if value > (@highest || 0)
end

def memory.highest
  @highest
end

evaluate_program(input, memory)
puts "Solution 1: #{memory.values.max}"
puts "Solution 1: #{memory.highest}"

