class Grid
  attr_reader :grid, :player1, :player2
 
  def initialize
     @grid = Array.new(3) {Array.new(3)}
         @player1 = Player.new('Player1')
         @player2 = Player.new('Player2')
  end
  
  def display
    grid.each_with_index do |row, i|
      row.each_with_index do |space, j| 
        print " #{space} "
        (j == 2) ? print("\n") : print("|")
      end
      print("---+---+--\n") unless i == 2
    end
  end

  def display_winner(name)
    puts "#{name} won the game!!"
  end

  def add_player1_entries
    row = player1.entries[:row]
    col = player1.entries[:col]
    grid[row][col] = 'X' 
  end

  def add_player2_entries
    row = player2.entries[:row]
    col = player2.entries[:col]
    grid[row][col] = 'O' 
  end

  def row_match?(symbol)
    grid.any? do |row|
      row.all? {|entry| entry == symbol}
    end
  end

  def col_match?(symbol)
    0.upto(3) do |i|
      return true if (grid[0][i] == symbol &&
                      grid[1][i] == symbol &&
                      grid[2][i] == symbol)
    end

      return false
  end

  def diagonal_match?(symbol)
    (grid[0][0] == symbol && grid[1][1] == symbol && grid[2][2] == symbol) ||
    (grid[0][2] == symbol && grid[1][1] == symbol && grid[2][0] == symbol)
  end

  def player1_match?
    row_match?('X') || col_match?('X') || diagonal_match?('X')
  end

  def player2_match?
    row_match?('O') || col_match?('O') || diagonal_match?('O')
  end

  def empty_space?
    grid.any? do |row|
      row.any? {|entry| entry.nil?}
    end
  end

  def invalid_entries?(entries)
    !entries[:row].between?(0, 2) || !entries[:col].between?(0, 2) || grid[entries[:row]][entries[:col]]
  end
end