def process(analysis, stream)
  return {:cancelled => false} if analysis[:cancelled]
  return {:cancelled => true} if stream.start_with? "!"
  return {:within_garbage => false} if stream.start_with? ">"
  return {:garbage => analysis[:garbage] + 1} if analysis[:within_garbage]
  return {:within_garbage => true} if stream.start_with? "<"
  return {:score => analysis[:score] + analysis[:depth], :depth => analysis[:depth] + 1} if stream.start_with? "{"
  return {:depth => analysis[:depth] - 1} if stream.start_with? "}"
  {}
end

def analyze(stream)
  stream.chars.reduce({:score => 0,
                       :depth => 1,
                       :within_garbage => false,
                       :cancelled => false,
                       :garbage => 0}) { |analysis, char| analysis.merge(process(analysis, char)) }
end

def total_score(stream)
  analyze(stream)[:score]
end

def count_garbage(stream)
  analyze(stream)[:garbage]
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
puts "Part 1: #{total_score(input)}"
puts "Part 2: #{count_garbage(input)}"