Cube = Struct.new(:x, :y, :z) do
  ORIGIN = new(0, 0, 0)

  def add(cube)
    Cube.new(x + cube.x, y + cube.y, z + cube.z)
  end

  def distance(other = ORIGIN)
    ((x - other.x).abs + (y - other.y).abs + (z - other.z).abs) / 2
  end

  def coords
    [x, y, z]
  end
end

DIRECTIONS = {
    :n => Cube.new(0, 1, -1),
    :ne => Cube.new(1, 0, -1),
    :se => Cube.new(1, -1, 0),
    :s => Cube.new(0, -1, 1),
    :sw => Cube.new(-1, 0, 1),
    :nw => Cube.new(-1, 1, 0),
}

def move(directions, from = ORIGIN)
  Enumerator.new { |y|
    for dir in directions
      from = from.add(DIRECTIONS[dir])
      y << from
    end
  }
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
moves = input.split(",").map &:to_sym

puts "Part 1: #{move(moves).to_a.last.distance}"
puts "Part 2: #{move(moves).max_by(&:distance).distance}"