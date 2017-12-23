require 'lib/day10/knot_hash'

def to_bits(hexa)
  hexa.chars.map {|c| "%04b" % c.to_i(16)}.join("")
end

def decode(key)
  to_bits(dense_hash_of(key)).chars.map &:to_i
end

def disk(key)
  (0...128).map {|row| decode("#{key}-#{row}")}
end

def used(disk)
  disk.flatten.reduce &:+
end

input = "ffayrhll"

puts "Part 1: #{used(disk(input))}"