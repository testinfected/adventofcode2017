require 'lib/day10/knot_hash'
require 'set'

def to_bits(hexa)
  hexa.chars.map {|c| "%04b" % c.to_i(16)}.join("")
end

def decode(key)
  to_bits(dense_hash_of(key)).chars.map &:to_i
end

Disk = Struct.new(:grid) do
  def self.decrypt(key)
    Disk.new((0...128).map {|row| decode("#{key}-#{row}")})
  end

  def total_used
    grid.flatten.reduce &:+
  end

  def neighbors_of(row, col)
    [[0, -1], [1, 0], [0, 1], [-1, 0]].map {|x, y| [row + x, col + y]}.select {|x, y| valid?(x, y)}
  end

  def used?(row, col)
    grid[row][col] == 1
  end

  def valid?(row, col)
    row >= 0 and row < grid.size and col >= 0 and col < grid[row].size
  end

  def region_containing(square)
    frontier, visited = [square], [square]
    until frontier.empty?
      neighbors_of(*frontier.shift).select {|neighbor| used?(*neighbor) and not visited.include?(neighbor)}
                                   .each {|neighbor| frontier << neighbor and visited << neighbor}
    end
    visited.to_set
  end

  def each_used_square
    grid.each_index do |row|
      grid[row].each_index do |col|
        yield [row, col] if used?(row, col)
      end
    end
  end

  def all_regions
    regions = []
    each_used_square do |square|
      regions << region_containing(square) unless regions.any? {|region| region.include? square}
    end
    regions
  end

  def total_regions
    all_regions.size
  end
end


disk = Disk.decrypt("ffayrhll")
puts "Part 1: #{disk.total_used}"
puts "Part 2: #{disk.total_regions}"