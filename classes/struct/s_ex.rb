BoardGames = Struct.new(:name, :num_of_players, :difficulty, :time_per_game) do
  def show_game
    puts "#{name}, #{num_of_players}, #{difficulty}, #{time_per_game}"
  end
end

scrabble = BoardGames.new('Scrabble', [2, 4], 'Easy', [60, 120])

scrabble.show_game
p scrabble.difficulty

class BoardGamesClass
  attr_reader :a_name, :players

  def initialize(a_name, p_min, p_max, diff, t_min, t_max)
    @a_name = a_name
    @players = [p_min, p_max]
    @diff = diff
    @time = [t_min, t_max]
  end
end

monopoly = BoardGamesClass.new('Monopoly', 3, 6, 'Medium', 100, 180)

puts monopoly.a_name
p monopoly.players
