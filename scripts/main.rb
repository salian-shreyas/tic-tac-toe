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


class Player
  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end


Game.welcome

player1 = Game.create_player 1
player2 = Game.create_player 2
