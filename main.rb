require_relative 'lib/grid'
require_relative 'lib/player'

grid = Grid.new
grid.display

while true
  grid.player1.get_entry
  grid.add_player1_entry
  grid.display
  if grid.player1_match?
    grid.display_winner grid.player1.name
    break
  end

  if !grid.empty_space?
    puts "Game Tie!!"
    break
  end

  grid.player2.get_entry
  grid.add_player2_entry
  grid.display
  if grid.player2_match?
    grid.display_winner grid.player2.name
    break
  end
end