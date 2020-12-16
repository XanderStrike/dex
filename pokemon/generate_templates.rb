# frozen_string_literal: true

require 'erb'
require 'oakdex/pokedex'
require 'pry'

$weaknesses = {}
Oakdex::Pokedex::Type.all.each do |weak_type|
  $weaknesses[weak_type.first] = {}
  Oakdex::Pokedex::Type.all.each do |type|
    eff = type[1].effectivness[weak_type.first]
    $weaknesses[weak_type.first][type.first] = eff
  end
end

# does a thing
class Renderer
  attr_reader :template, :pokemon, :types, :damage, :learnset

  def initialize(id)
    @template = File.open('pokemon.html.erb', 'rb', &:read)
    @pokemon = Oakdex::Pokedex::Pokemon.find(id)
    @types = types
    @damage = damage.sort_by { |_k, v| v }.reverse
    @learnset = learnset
  end

  def render
    ERB.new(template).result(binding)
  end

  private

  def types
    @pokemon.types.map do |type|
      Oakdex::Pokedex::Type.find(type)
    end
  end

  def damage
    return $weaknesses[@types.first.names['en']] if @types.count == 1

    list1 = $weaknesses[@types.first.names['en']]
    list2 = $weaknesses[@types.last.names['en']]

    damage = {}
    list1.keys.each do |k|
      damage[k] = list1[k] * list2[k]
    end
    damage
  end

  def learnset
    @pokemon.move_learnsets.each do |set|
      next unless set['games'].include?('X')

      return parse_learnset(set['learnset'])
    end
    parse_learnset(@pokemon.move_learnsets.last['learnset'])
  end

  def parse_learnset(moves)
    moves.each do |m|
      m['type'] = Oakdex::Pokedex::Move.find(m['move']).type
      m['level'] = 'egg' if m['egg_move']
      m['level'] = m['tm'] unless m['tm'].nil?
    end
    moves
  end
end

names = []
puts 'generating'
all_pokemon = Oakdex::Pokedex::Pokemon.all
all_pokemon.keys.each do |name|
  id = all_pokemon[name].national_id
  puts "Running id #{id}"
  html = Renderer.new(id).render
  File.write("#{id}.html", html)
  names << {
    id: id,
    name: name.downcase,
    types: all_pokemon[name].types.sort.join('-').downcase
  }
end
File.write('../names.json', names.sort_by { |x| x[:id] }.to_json)
puts 'done'
