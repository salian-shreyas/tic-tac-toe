require 'pry-byebug'

module Game
  def self.create_player(player)
    player_info = self.prompt_player(player)

    Player.new(player_info.first, player_info.last)
  end

  def self.prompt_player(player)
    print "Player #{player}, enter your name: "
    player_name = gets.chomp
    mark = (player == 1) ? 'X' : 'O'

    puts "Hello, #{player_name}! Your mark is '#{mark}'"

    [player_name, mark]
  end

  def self.welcome
    puts "Welcome to Tic-Tac-Toe Game\n"
  end

end


class Board
  @@data = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
  ]

  def self.display
    @@data.each_with_index do |row, row_idx|
      
      row.each_with_index do |item, item_idx|
        print " #{item} "
        print "|" unless item_idx == 2
      end
    
      puts "\n---|---|---" unless row_idx == 2
    end

    puts ""
  end

  def self.edit(row_idx, col_idx, value)
    @@data[row_idx][col_idx] = value
  end

end

class Player
  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end


Game.welcome

player1 = Game.create_player 1
player2 = Game.create_player 2

Board.display
