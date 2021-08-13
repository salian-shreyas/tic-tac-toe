# frozen_string_literal: true

# Game module
module Game
  def self.create_player(player)
    player_info = prompt_player(player)

    Player.new(player_info.first, player_info.last)
  end

  def self.prompt_player(player)
    print "Player #{player}, enter your name: "
    player_name = gets.chomp
    mark = player == 1 ? 'X' : 'O'

    puts "Hello, #{player_name}! Your mark is '#{mark}'"

    [player_name, mark]
  end

  def self.welcome
    puts "Welcome to Tic-Tac-Toe Game\n"
  end

  def self.winner?
    false
  end
end

# Class representing tic-tac-toe board
class Board
  attr_reader :data

  def initialize
    @data = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  end

  def display
    data.each_with_index do |row, row_idx|
      print ' ' * 10

      row.each_with_index do |item, item_idx|
        print " #{item} "
        print '|' unless item_idx == 2
      end

      print "\n#{' ' * 10}"
      puts '---|---|---' unless row_idx == 2
    end

    puts ''
  end

  def edit(number, value)
    index = index_of number
    data[index.first][index.last] = value
  end

  def index_of(number)
    number -= 1
    [number / 3, number % 3] # row index, col index
  end

  def value_at(number)
    index = index_of number
    value_at_index(index.first, index.last)
  end

  def value_at_index(row_idx, col_idx)
    data[row_idx][col_idx]
  end
end

# Class representing player
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name.capitalize
    @mark = mark.capitalize
  end

  def prompt(board)
    puts "#{name}'s turn"
    loop do
      print "Choose one from above available number to mark '#{mark}': "
      choice = gets.chomp.to_i
      break if valid_choice?(choice, board)
      print "#{choice} is not available!"
    end
    choice
  end

  def valid_choice?(choice, board)
    value = board.value_at(choice)
    return false if choice.between?(1, 9) || ['X', 'O'].include? value
    return true
  end
end

# Start game
Game.welcome

board = Board.new

player1 = Game.create_player 1
player2 = Game.create_player 2

until Game.winner?
  board.display

  choice = player1.prompt(board)
  board.edit(choice, 'X')
  choice = player2.prompt(board)
  board.edit(choice, 'O')
end
