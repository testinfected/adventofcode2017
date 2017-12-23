Graph = Struct.new(:edges) do
  def groups
    edges.keys.map { |location| reachable_from(location) }.uniq
  end

  def reachable_from location
    frontier, visited = [location], [location]

    until frontier.empty?
      edges[frontier.shift].select {|edge| not visited.include? edge }
                           .each {|edge| frontier << edge and visited << edge }
    end

    visited.sort
  end
end

def edges_in(record)
  /^(?<location>.*?)\s<->\s(?<connections>.*)$/ =~ record
  [location, connections.split(",").map(&:strip)]
end

def graph_of(input)
  Graph.new(input.split("\n").map { |line| edges_in(line) }.to_h)
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))

puts "Part 1: #{graph_of(input).reachable_from("0").size}"
puts "Part 2: #{graph_of(input).groups.size}"