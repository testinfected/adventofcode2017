def reverse(list, length)
  list[0...length].reverse + list[length..-1]
end

def tie(marks, position, length)
  reverse(marks.rotate(position), length).rotate(-position)
end

Knots = Struct.new(:marks, :pos, :skip_size)

def tie_knots(lengths, knots)
  lengths.reduce(knots) do |knots, len|
    Knots.new(tie(knots.marks, knots.pos, len), knots.pos + knots.skip_size + len, knots.skip_size + 1)
  end
end

def knot_hash(lengths, marks = (0..255).to_a)
  knots = tie_knots(lengths, Knots.new(marks, 0, 0))
  knots.marks[0..1].reduce(&:*)
end

def sparse_hash(lengths, marks = (0..255).to_a)
  knots = (1..64).inject(Knots.new(marks, 0, 0)) { |knots, _| tie_knots(lengths, knots) }
  knots.marks
end

def dense_hash(lengths, marks = (0..255).to_a)
  sparse = sparse_hash(lengths, marks)
  dense = sparse.each_slice(16).to_a.map { |block| xor(block) }
  to_hex(dense)
end

def to_numbers(input)
  input.split(",").map(&:to_i)
end

def to_ascii(input)
  input.chars.map &:ord
end

def to_hex(numbers)
  numbers.map { |n| "%02x" % n }.join
end

def xor(block)
  block.reduce &:^
end

def knot_hash_of(input)
  knot_hash(to_numbers(input))
end

def dense_hash_of(input)
  dense_hash(to_ascii(input) + [17, 31, 73, 47, 23])
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
puts "Part 1: #{knot_hash_of(input)}"
puts "Part 2: #{dense_hash_of(input)}"
