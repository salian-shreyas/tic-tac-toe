require_relative 'lib/grid'
require_relative 'lib/player'

grid = Grid.new
grid.display

while true
  loop do
    grid.player1.get_entries
    break unless grid.invalid_entries?(grid.player1.entries)
  end 
  grid.add_player1_entries
  grid.display
  if grid.player1_match?
    grid.display_winner grid.player1.name
    break
  end

  if !grid.empty_space?
    puts "Game Tie!!"
    break
  end

  loop do
    grid.player2.get_entries
    break unless grid.invalid_entries?(grid.player2.entries)
  end 
  grid.add_player2_entries
  grid.display
  if grid.player2_match?
    grid.display_winner grid.player2.name
    break
  end
end