Tower = Struct.new(:program, :weight, :sub_programs) do
  def total_weight(towers)
    sub_programs.inject(weight) {|total, sub_program| total + towers[sub_program].total_weight(towers)}
  end

  def find_unbalanced(towers)
    by_weight = sub_programs_by_weight(towers)
    return [] if by_weight.length == 1

    unbalanced, weight_offset = by_weight.first.last.first, by_weight.last.first - by_weight.first.first
    [{:name => unbalanced, :weight_offset => weight_offset}] + towers[unbalanced].find_unbalanced(towers)
  end

  def sub_programs_by_weight(towers)
    sub_programs.group_by {|p| towers[p].total_weight(towers)}.sort_by {|_, programs| programs.length}
  end
end

def parse_sub_tower(structure)
  /(?<name>.*?)\s*\((?<weight>.*)\)(?:\s*->\s*(?<sub_programs>.*))?/ =~ structure
  [name, Tower.new(name, weight.to_i, sub_programs.nil? ? [] : sub_programs.split(", "))]
end

def parse_entire_tower(structure)
  structure.split(/\n/).map {|branch| parse_sub_tower(branch)}.to_h
end

def all_sub_programs(towers)
  towers.values.map {|tower| tower.sub_programs}.flatten
end

def base_tower(towers)
  towers.keys.detect {|name| !all_sub_programs(towers).include? name}
end

def weights(towers)
  towers.map {|name, tower| [name, tower.total_weight(towers)]}.to_h
end

def balance_tower(towers)
  unbalanced = towers[base_tower(towers)].find_unbalanced(towers)
  culprit = unbalanced.last
  [culprit[:name], towers[culprit[:name]].weight + culprit[:weight_offset]]
end

input = File.read(File.join(File.dirname(__FILE__), 'input.txt'))
towers = parse_entire_tower(input)
puts base_tower(towers)
puts balance_tower(towers)