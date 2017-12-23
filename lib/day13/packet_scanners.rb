def scanner(definition)
  definition.match(/([\d]+)+:\s(\d+)/).captures.map(&:to_i)
end

def firewall(study)
  study.split("\n").map {|definition| scanner(definition)}.to_h
end

def scanner_position(range, time)
  steps = time % (2 * (range - 1))
  steps < range ? steps : 2 * (steps - 1) - steps
end

def ride_packet(firewall, delay = 0)
  firewall.select {|depth, range| scanner_position(range, depth + delay) == 0}
end

def trip_severity(firewall, delay = 0)
  ride_packet(firewall, delay).map {|depth, range| depth * range }.reduce(0, &:+)
end

def delay(firewall)
  (1..Float::INFINITY).lazy.detect {|delay| ride_packet(firewall, delay).empty?}
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))

puts "Part 1: #{trip_severity(firewall(input))}"
puts "Part 2: #{delay(firewall(input))}"