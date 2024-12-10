class Grid
	attr_reader :grid

	def initialize
		@grid = Array.new(3) {Array.new(3, ' ')}
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
end

grid = Grid.new
grid.display
