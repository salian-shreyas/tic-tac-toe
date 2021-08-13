# frozen_string_literal: true

# Game module
module Game
  def self.create_player(player)
    player_info = prompt_player(player)

    Player.new(player_info.first, player_info.last)
  end

  def self.prompt_player(player)
    print "Player #{player}, enter your name: "
    player_name = gets.chomp.capitalize
    mark = player == 1 ? 'X' : 'O'

    puts "Hello, #{player_name}! Your mark is '#{mark}'\n\n"

    [player_name, mark]
  end

  def self.welcome
    puts "Welcome to Tic-Tac-Toe Game\n\n"
  end

  def self.winner?(board)
    return board.match?
  end
  
  def self.stop?(spots, board)
    (spots < 5) && (winner?(board) || spots <= 0)
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
    puts ''

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
  
  def match?
    return horizontal_match? ||
           vertical_match? ||
           diagonal_match?
  end

  def horizontal_match?
    data.each do |row|
      mark = row[0]
      if row.all? { |item| item == mark }
        Player.winner = Player.players[mark]
        return true
      end
    end

    false
  end

  def vertical_match?
    start = 1
    3.times do |col_idx|
      mark = data[0][col_idx]
      count = 1

      start.upto(2) do |row_idx|
        if data[row_idx][col_idx] == mark
          count += 1
        else 
          break
        end
      end

      if count == 3
        Player.winner = Player.players[mark]
        return true
      end
    end

    false
  end

  def diagonal_match?
    if [data[1][1], data[2][2]].all? { |item| item == data[0].first }
      Player.winner = Player.players[data[0].first]
      return true
    end

    if [data[1][1], data[2][0]].all? { |item| item == data[0].last }
      Player.winner = Player.players[data[0].last]
      return true
    end

    false
  end
end

# Class representing player
class Player
  @@players = {}
  @@winner = nil

  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
    @@players[@mark] = @name
  end

  def self.players
    @@players
  end

  def self.winner
    @@winner
  end

  def self.winner=(name)
    @@winner = name
  end

  def prompt(board)
    choice = ''

    puts "#{name}'s turn"
    loop do
      print "Choose one from above available number to mark '#{mark}': "
      choice = gets.chomp.to_i
      break if valid_choice?(choice, board)
      puts "#{choice} is not available!"
    end

    choice
  end

  def valid_choice?(choice, board)
    choice.between?(1, 9) &&
    ['X', 'O'].none? { |item| item == board.value_at(choice) }
  end

end

# Start game
Game.welcome

board = Board.new

player1 = Game.create_player 1
player2 = Game.create_player 2

spots = 9
board.display

loop do
  choice = player1.prompt(board)
  board.edit(choice, 'X')
  spots -= 1
  board.display

  break if Game.stop?(spots, board)

  choice = player2.prompt(board)
  board.edit(choice, 'O')
  spots -= 1
  board.display

  break if Game.stop?(spots, board)
end

if Player.winner
  puts "---#{Player.winner} Won!---" 
else
  puts "---Game Tied---"
end
